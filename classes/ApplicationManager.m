//
//  UpdateManager.m
//  Fantrature
//
//  Created by Haseeb Yousaf on 4/27/11.
//  Copyright 2011 Penta::Loop inc. All rights reserved.
//

#import "ApplicationManager.h"
#import "wax.h"
#import "wax_http.h"
#import "wax_json.h"
#import "wax_xml.h"
#import "lauxlib.h"

@implementation ApplicationManager

@synthesize currentApplicationVersion;
@synthesize delegate;
@synthesize update;
//=========================================================================
#pragma mark CONSTANTS
//=========================================================================
SYNTHESIZE_SINGLETON_FOR_CLASS(ApplicationManager);
static const int ddLogLevel = APP_LOG_LEVEL;
#define kPLConfigurationApplicationVersion @"com.pentaloop.applicationVersion"
#define kPLApplicationManagerBaseVersionInitialized [NSString stringWithFormat:@"com.pentaloop.%@.baseVersionInitialized", [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey]]
//=========================================================================
#pragma mark CUSTOM GETTER/SETTERS
//=========================================================================
-(NSString*)currentApplicationVersion {
	NSString* version = [[PLUserDefaults sharedPLUserDefaults] stringForKey:kPLConfigurationApplicationVersion];
	if (!version) {
		version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey];
	}
	return version;
}


+(NSString*)scriptPath {
	return [NSString stringWithFormat:@"%@/%@/scripts/",[Helper  applicationDocumentsDirectory], [ApplicationManager sharedApplicationManager].currentApplicationVersion];
}

//=========================================================================
#pragma mark -
#pragma mark Initialize
//=========================================================================
-(void)initializeBaseVersionScripts {
#ifndef DEBUG
	BOOL initialized = [[PLUserDefaults sharedPLUserDefaults] boolForKey:kPLApplicationManagerBaseVersionInitialized defaultValue:NO];
	if (!initialized)
#endif
	{
		NSError* error = nil;
		NSString* srcPath = [Helper resourcePath:@"scripts"];
		NSString* version = self.currentApplicationVersion;
		NSString* destPath = [NSString stringWithFormat:@"%@/%@/scripts/",[Helper  applicationDocumentsDirectory], version];
		[[NSFileManager defaultManager] createDirectoryAtPath:destPath withIntermediateDirectories:YES attributes: nil error:&error];
		
		NSArray *fileNames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:srcPath error:nil];
		for (NSString * fileName in fileNames) {
			if ([fileName rangeOfString:@"\\.(lua|dat|plist)$" options:NSRegularExpressionSearch|NSCaseInsensitiveSearch].length != 0) {
				NSString* srcFile = [srcPath stringByAppendingPathComponent:fileName];
				NSString* destFile = [destPath stringByAppendingPathComponent:fileName];
				Log(@"Copying %@ to %@",fileName, destPath);
				if ([[NSFileManager defaultManager] fileExistsAtPath:destFile]) {
					[[NSFileManager defaultManager] removeItemAtPath:destFile error:&error];
				}
				[[NSFileManager defaultManager] copyItemAtPath:srcFile toPath:destFile error:&error];
				Log(@"Result:%@",error);
			} else if ([Helper folderExistsWithPath:[srcPath stringByAppendingPathComponent:fileName]]) {
				NSError* error = nil;
				Log(@"Copying %@ to %@",fileName, destPath);
				[[NSFileManager defaultManager] moveItemAtPath:[srcPath stringByAppendingPathComponent:fileName] toPath:[destPath stringByAppendingPathComponent:fileName] error:&error];
				Log(@"Result:%@",error);
			}

		}
		[[PLUserDefaults sharedPLUserDefaults] setBool:YES forKey:kPLApplicationManagerBaseVersionInitialized];
		[[PLUserDefaults sharedPLUserDefaults] setString:version forKey:kPLConfigurationApplicationVersion];
	}
}


-(void)loadScripts {
	//LogStart;
	//NSString* path = [NSString stringWithFormat:@"%@/%@/scripts/",[Helper  applicationDocumentsDirectory], self.currentApplicationVersion];
	//NSArray *fileNames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
	NSString* loop2dClassesPlistPath = [[ApplicationManager scriptPath] stringByAppendingPathComponent:@"loop2dClasses.plist"];
	NSString* classesPlistPath = [[ApplicationManager scriptPath] stringByAppendingPathComponent:@"classes.plist"];
	
	NSMutableArray* fileNames = [[NSMutableArray alloc] init];	
	NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:loop2dClassesPlistPath];
	if (dict) {
		NSArray* classesList = [dict objectForKey:@"classes"];
		if (classesList) {
			[fileNames addObjectsFromArray:classesList];
		}
		safeRelease(dict)
	}
	dict = [[NSDictionary alloc] initWithContentsOfFile:classesPlistPath];
	if (dict) {
		NSArray* classesList = [dict objectForKey:@"classes"];
		if (classesList) {
			[fileNames addObjectsFromArray:classesList];
		}
		safeRelease(dict)
	}
	
	// Now loading the classes
	for (NSString * fileName in fileNames) {
		if ([fileName rangeOfString:@"\\.(lua|dat)$" options:NSRegularExpressionSearch|NSCaseInsensitiveSearch].length != 0) {
			NSString* filePath = [[ApplicationManager scriptPath] stringByAppendingPathComponent:fileName];
			lua_State *L = wax_currentLuaState();
			Log(@"Loading class:%@",filePath);
			if(luaL_dofile(L, [filePath cStringUsingEncoding:NSASCIIStringEncoding]) != 0) {
				fprintf(stderr,"Error opening wax scripts: %s\n", lua_tostring(L,-1));
			}
		}
	}
	safeRelease(fileNames);
	//LogEnd;
}

//=========================================================================
#pragma mark -
#pragma mark Update
//=========================================================================
-(void)beginUpdate {
	//LogStart;
	[NSThread detachNewThreadSelector:@selector(updateWorker) toTarget:self withObject:nil];
	//LogEnd;
	
}


-(void)updateWorker {
	//LogStart;
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	update = [self checkUpdate];
	if (update) {
		Log(@"New update is available:%@",update.version);
		BOOL downloadSuccess = [self downloadUpdate:update];
		if (downloadSuccess) {
			Log(@"Update Download successfull");
			[self installUpdate:update];
		}
	}
	[pool release];
	//LogEnd;
}


-(Update*)checkUpdate {
	Update* result = nil;
	// Create the url
	NSMutableString* urlStr = [NSMutableString stringWithString:PLServerUrl];
	[urlStr appendFormat:@"/update/check?format=json&version=%@",self.currentApplicationVersion];
	urlStr = [self appendDeviceInfoToUrlString:urlStr];
	Log(@"url:%@",urlStr);
	// Send the request
	NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	//Log(@"nsurl:%@",url);
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request  startSynchronous];
	NSError *error = [request error];
	if (!error) {
		Log(@"result:%@",[request responseString]);
		NSData *response = [request responseData];
		NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:response error:&error];
		if (!error) {
			NSString* responseCode = [dictionary objectForKey:@"response_code"];
			if (response && [responseCode isEqualToString:@"0001"]) {
				result = [[Update alloc] init];
				NSDictionary* poiDict = [dictionary objectForKey:@"update"];
				result = [[Update alloc] init];
				result.version = [poiDict objectForKey:@"version"];
				result.downloadUrl = [poiDict objectForKey:@"url"];
				if (delegate && [delegate respondsToSelector:@selector(appManager:newUpdateAvailable:)]) {
					[delegate appManager:self newUpdateAvailable:update];
				}
				//Log(@"%@",dictionary);
			}
		}
	}
	return result;
}


-(BOOL)downloadUpdate:(Update*)anUpdate {
	if (update && update.downloadUrl) {
		NSError *error = nil;
		NSString* path = [NSString stringWithFormat:@"%@/%@/",[Helper  applicationDocumentsDirectory], anUpdate.version];
		[[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes: nil error:&error];
		NSString* filePath = [NSString stringWithFormat:@"%@/%@/%@",[Helper  applicationDocumentsDirectory], anUpdate.version, [anUpdate.downloadUrl lastPathComponent]];
		NSString* filePathTemp = [NSString stringWithFormat:@"%@/%@/%@.tmp",[Helper  applicationDocumentsDirectory], anUpdate.version, [anUpdate.downloadUrl lastPathComponent]];
		ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:anUpdate.downloadUrl]];
		[request setDownloadDestinationPath:filePath];
		[request setTemporaryFileDownloadPath:filePathTemp];
		[request setDelegate:self];
		[request setDownloadProgressDelegate:self];
		[request setTimeOutSeconds:60];
		[request setShowAccurateProgress:YES];
		[request setAllowResumeForFileDownloads:YES];
		[request setUserInfo:[NSDictionary dictionaryWithObject:anUpdate forKey:@"update"]];
		[request startAsynchronous];		
		while (!request.complete) {
			[NSThread sleepForTimeInterval:1];
		}
	}
	return YES;
}

// ==============================================================
#pragma mark -
#pragma mark Download
// ==============================================================
- (void)requestStarted:(ASIHTTPRequest *)req {
	//LogStart;
	if (delegate && [delegate respondsToSelector:(@selector(appManager:newUpdateDownloadStarted:))]) {
		[delegate appManager:self newUpdateDownloadStarted:[[req userInfo] valueForKey:@"update"]];
	}
	//LogEnd;
}

int size = 0;
- (void)request:(ASIHTTPRequest *)req incrementDownloadSizeBy:(NSInteger)s {
	//LogStart;
	size+=s;
	//Log(@"download size:%f MB",((float)size/(1024.0*1024.0)));
	//LogEnd;
}

int downloaded = 0;
- (void)request:(ASIHTTPRequest *)req didReceiveBytes:(NSInteger)s {
	////LogStart;
	downloaded+=s;
	//Log(@"download size:%f % new: %d",((float)downloaded/size) * 100.0f, s);
	if (delegate && [delegate respondsToSelector:(@selector(appManager:newUpdateDownloadPercent:))]) {
		[delegate appManager:self newUpdateDownloadPercent:((float)downloaded/size) * 100.0f];
	}
	////LogEnd;
}

- (void)requestFinished:(ASIHTTPRequest *)req {
	//LogStart;
	//Log(@"request finished");
	if (delegate && [delegate respondsToSelector:(@selector(appManager:newUpdateDownloadFinished:))]) {
		[delegate appManager:self newUpdateDownloadFinished:[[req userInfo] valueForKey:@"update"]];
	}
	//LogEnd;
}


- (void)requestFailed:(ASIHTTPRequest *)req {
	//LogStart;
	NSError *error = [req error];
	//Log(@"ERROR:%@",error);
	if (delegate && [delegate respondsToSelector:(@selector(appManager:newUpdateDownloadFailed:))]) {
		[delegate appManager:self newUpdateDownloadFailed:[[req userInfo] valueForKey:@"update"]];
	}
	//LogEnd;
}



-(void)installUpdate:(Update*)anUpdate {
	//////LogEnd;
	if (delegate && [delegate respondsToSelector:(@selector(appManager:newUpdateInstallationStarted:))]) {
		[delegate appManager:self newUpdateInstallationStarted:anUpdate];
	}
	NSString* filePath = [NSString stringWithFormat:@"%@/%@/%@",[Helper  applicationDocumentsDirectory], anUpdate.version, [anUpdate.downloadUrl lastPathComponent]];
	NSString* extractPath = [NSString stringWithFormat:@"%@/%@/",[Helper  applicationDocumentsDirectory], anUpdate.version];
	//filePath = [Helper resourcePath:@"scripts.zip"];
	BOOL ret = [SSZipArchive unzipFileAtPath:filePath toDestination:extractPath];
	if(!ret) {
		//Log(@"Installation Failed");
		if (delegate && [delegate respondsToSelector:(@selector(appManager:newUpdateInstallationFailed:))]) {
			[delegate appManager:self newUpdateInstallationFailed:anUpdate];
		}
	} else {
		Log(@"Installation Successfull");
		[[PLUserDefaults sharedPLUserDefaults] setString:anUpdate.version forKey:kPLConfigurationApplicationVersion];
		if (delegate && [delegate respondsToSelector:(@selector(appManager:newUpdateInstallationComplete:))]) {
			[delegate appManager:self newUpdateInstallationComplete:anUpdate];
		}
	}
	//LogEnd;
}


//=========================================================================
#pragma mark -
#pragma mark helper
//=========================================================================
-(NSMutableString*)appendDeviceInfoToUrlString:(NSMutableString*)url {
	[url appendFormat:@"&device_id=%@",[UIDevice currentDevice].uniqueIdentifier];
	[url appendFormat:@"&device_name=%@",[UIDevice currentDevice].name];
	[url appendFormat:@"&device_system_name=%@",[UIDevice currentDevice].systemName];
	[url appendFormat:@"&device_system_version=%@",[UIDevice currentDevice].systemVersion];
	return url;
}

//=========================================================================
#pragma mark -
#pragma mark Mem
//=========================================================================
- (void)dealloc
{
	[update release];
	update = nil;
	
	[super dealloc];
}

@end
