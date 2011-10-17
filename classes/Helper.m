//
//  Util.m
//  SSP.Cocoa
//
//  Created by Mikhail Burilov on 4/8/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Helper.h"
#import <AudioToolbox/AudioServices.h>

@implementation RectObj 
@synthesize rect;
-(id) initWithFrame:(CGRect) frame {
	if (self = [super init]) {
		self.rect = frame;
	}
	return self;
}
@end

@implementation KeyValuePair
@synthesize key, value;

+(id) pairWithKey:(NSString*) _key value:(id) _value {
	KeyValuePair* pair = [[[KeyValuePair alloc] init] autorelease];
	[pair setKey:_key];
	[pair setValue:_value];
	return pair;
}

@end


@implementation Helper

//
// Simple getting color
//
+(UIColor*) colorWithR:(int) r G:(int) g B:(int) b {
	return [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1.0f];
}

+(UIColor*) colorWithR:(int) r G:(int) g B:(int) b A:(float) a {
	return [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:a];
}

//
// System blue font
//
+(UIColor*) systemBlueFontColor {
	return [self colorWithR:94 G:113 B:162];
}

//return standart frame size
+(CGRect) standartFrame{
	return CGRectMake(0, 0, 320, 480);
}

+(CGRect) landscapeStandartFrame{
	return CGRectMake(0, 0, 480, 320);
}

//Create default view with image on background
+(UIImageView*) createViewWithImage:(NSString*) imgName{
	UIImageView* imgView = [[[UIImageView alloc] initWithFrame:[self standartFrame]] autorelease];
	[imgView setUserInteractionEnabled:YES];
	UIImage* img = [UIImage imageNamed:imgName];	
	[imgView setImage:img];
	return imgView;
}


+(bool) fileExistsWithPath:(NSString*) path{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}


+(bool)folderExistsWithPath:(NSString*) path {
	BOOL isFolder = NO;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if ([fileManager fileExistsAtPath:path isDirectory:&isFolder]) {
		if (isFolder) {
			return YES;
		}
	}
	return NO;
}

+(bool) createEmptyFileWithPath:(NSString*) path{
	//	NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
	//						 [NSDate date],NSFileModificationDate,
	//						 @"owner",@"NSFileOwnerAccountName",
	//						 @"group",@"NSFileGroupOwnerAccountName",
	//						 nil,@"NSFilePosixPermissions",
	//						 [NSNumber numberWithBool:YES],@"NSFileExtensionHidden",
	//						 nil];
	//	
	//	return [[NSFileManager defaultManager] createFileAtPath:path contents:@"" attributes:dic];
	return YES;
}

+(void) sendEmailTo:(NSString*) to withSubject:(NSString*) subject withBody:(NSString*) body{
	NSString* mailString = [NSString stringWithFormat:@"mailto:%@?subject=%@&body=%@", 
							[to stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
							[subject stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
							[body stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailString]];
}

/*
 * Searching keyboard
 */
+(UIView*) getKeyboard {
	UIView* kbrd;
	UIWindow* tempWindow;
	
	for(int c = 0; c < [[[UIApplication sharedApplication] windows] count]; c ++) {
		//Get a reference of the current window
		tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:c];
		
		//Get a reference of the current view 
		for(int i = 0; i < [tempWindow.subviews count]; i++) {
			kbrd = [tempWindow.subviews objectAtIndex:i];
			
			if([[kbrd description] hasPrefix:@"<UIKeyboard"]) {
				return kbrd;
			}
		}
	}
	return nil;
}

+(UIView*) view:(UIView*) container subviewWithTag:(NSInteger) tag {
	for(UIView* view in container.subviews) {
		if (view.tag == tag) {
			return view;
		}
	}
	return nil;
}

+(UIView*) subviewOf:(UIView*) container withTag:(NSInteger) tag {
	for(UIView* view in container.subviews) {
		if (view.tag == tag) {
			return view;
		} else {
			UIView* result = [Helper subviewOf:view withTag:tag];
			if (result) {
				return result;
			}
		}
	}
	return nil;
}

+(UIView*) rootViewOf:(UIView*) view {
	if (!view.superview) {
		return view;
	}
	return [Helper rootViewOf:view.superview];
}

/**
 * Add new pair value/key into dictionary. Shorting
 */
+(void) dict:(NSMutableDictionary*) dict addObject:(id) obj forKey:(NSString*) key {
	if (obj) {
		[dict addEntriesFromDictionary:[NSDictionary dictionaryWithObject:obj forKey:key]];
	}
}

+(NSString*) infinitySymbol {
	return @"∞";
}

+(void) exchange:(NSMutableArray*) array objectAtIndex:(NSInteger) index to:(id) newValue {
	[array removeObjectAtIndex:index];
	[array insertObject:newValue atIndex:index];
}

+(NSArray*) getImages:(NSArray*) namesArray {
	NSMutableArray* array = [[[NSMutableArray alloc] init] autorelease];
	for(NSString* name in namesArray) {
		[array addObject:[UIImage imageNamed:name]];
	}
	return array ;
}

+(NSArray*) getImageArray:(NSString*)firstArg, ...  {
	NSMutableArray* newArray = [[[NSMutableArray alloc] init] autorelease];
	[newArray addObject:firstArg];
    va_list arglist;
    va_start(arglist, firstArg);
    id arg = va_arg(arglist, id);
    while (arg != nil) {
		[newArray addObject:arg];
		arg = va_arg(arglist, id);
    }
    va_end(arglist);
	return [Helper getImages:newArray];
}

+(void) prepareAnimation: (NSTimeInterval) duration {
	CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:duration];	
	[UIView setAnimationBeginsFromCurrentState:YES];
}

+(void) commitAnimation {
	[UIView commitAnimations];
}

+(UILabel*) labelWithFrame:(CGRect) frame withFont:(UIFont*) font withText:(NSString*) text{	
	CGSize size = [text sizeWithFont:font 
				   constrainedToSize:CGSizeMake(frame.size.width, frame.size.height) 
					   lineBreakMode:UILineBreakModeWordWrap];
	CGSize size2 = [text sizeWithFont:font];
	float x = frame.origin.x + (frame.size.width - size.width)/2;
	float y = frame.origin.y + (frame.size.height - size.height)/2;
	UILabel* lbl = [[UILabel alloc] initWithFrame:CGRectMake(x, y, size.width, size.height)];
	[lbl setFont:font];
	[lbl setTextColor:[UIColor whiteColor]];
	[lbl setBackgroundColor:[UIColor clearColor]];
	[lbl setText:text];
	[lbl setLineBreakMode:UILineBreakModeWordWrap];
	[lbl setNumberOfLines:size.height/size2.height];
	return [lbl autorelease];
}

+(bool) fileExistsWithName:(NSString*) name{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:name];   
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if (![fileManager fileExistsAtPath:documentsDirectory]) {
		[fileManager createDirectoryAtPath:documentsDirectory attributes:nil];
	}
    return [fileManager fileExistsAtPath:filePath];
}

+(BOOL) isZeroRect:(CGRect) rect {
	return rect.origin.x==0 && rect.origin.y==0 && rect.size.width ==0 && rect.size.height == 0;
}

+(BOOL) rect:(CGRect) rect1 isInterseted:(CGRect) rect2 {
	if ([Helper isZeroRect:rect2]) {
		return NO;
	}
	
	if (rect1.origin.x == rect2.origin.x ||
		(rect1.origin.x < rect2.origin.x && (rect1.origin.x+rect1.size.width) > rect2.origin.x) ||
		(rect1.origin.x > rect2.origin.x && (rect2.origin.x+rect2.size.width) > rect1.origin.x)) {
		//		NSLog(@"Check Y pos");
		if (rect1.origin.y == rect2.origin.y ||
			(rect1.origin.y < rect2.origin.y && (rect1.origin.y+rect1.size.height) > rect2.origin.y) ||
			(rect1.origin.y > rect2.origin.y && (rect2.origin.y+rect2.size.height) > rect1.origin.y)) {
			return YES;
		}
	}
	return NO;
}

+(UIImageView*) getUIImageViewWithFrame:(CGRect) frame withBImage:(UIImage*) img{
	UIImageView* imgView = [[UIImageView alloc] initWithFrame:frame];
	[imgView setUserInteractionEnabled:true];
	[imgView setBackgroundColor:[UIColor clearColor]];
	[imgView setImage:img];
	return [imgView autorelease];
}

+(bool) setProp:(id*) object to:(id) value{
	if (*object == value){
		return false;
	}
	if (*object){
		[*object release];
		*object = nil;
	}
	if (value){
		*object = [value retain];
	}
	return true;
}

+(void) killObject:(id*) object{
	if (!*object){
		[*object release];
		*object = nil;
	}
}

static NSString* resourcePath = nil;

+(NSString*) resourcePath:(NSString*) fileName {
	if (!resourcePath) {
		resourcePath = [[[NSBundle mainBundle] resourcePath] retain];
	}
	return [resourcePath stringByAppendingPathComponent:fileName];
}

//**************************************************************
// Returns the path to the application's Documents directory.
//**************************************************************
+ (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


//**************************************************************
// Sound
//**************************************************************
+(void)playShortSound:(NSString*)soundFileName {
	SystemSoundID bell;  
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[Helper resourcePath:soundFileName]], &bell);  
	AudioServicesPlaySystemSound (bell);
}

@end
