//
//  UpdateManager.h
//  Fantrature
//
//  Created by Haseeb Yousaf on 4/27/11.
//  Copyright 2011 Penta::Loop inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSZipArchive.h"

@class Update;

@protocol ApplicationManagerDelegate;


@interface ApplicationManager : NSObject {
	id<ApplicationManagerDelegate> delegate;
	Update* update;
}

@property (nonatomic, readonly,getter=currentApplicationVersion) NSString *currentApplicationVersion;
@property (nonatomic, retain) id<ApplicationManagerDelegate> delegate;
@property (nonatomic, retain) Update *update;

+(ApplicationManager*)sharedApplicationManager;


-(void)initializeBaseVersionScripts;
-(void)loadScripts;

-(void)beginUpdate;

+(NSString*)scriptPath;
@end


@protocol ApplicationManagerDelegate 
-(void)appManager:(ApplicationManager*)manager newUpdateAvailable:(Update*)update;
-(void)appManager:(ApplicationManager*)manager newUpdateDownloadStarted:(Update*)update;
-(void)appManager:(ApplicationManager*)manager newUpdateDownloadPercent:(float)percent;
-(void)appManager:(ApplicationManager*)manager newUpdateDownloadFinished:(Update*)update;
-(void)appManager:(ApplicationManager*)manager newUpdateDownloadFailed:(Update*)update;
-(void)appManager:(ApplicationManager*)manager newUpdateInstallationStarted:(Update*)update;
-(void)appManager:(ApplicationManager*)manager newUpdateInstallationComplete:(Update*)update;
-(void)appManager:(ApplicationManager*)manager newUpdateInstallationFailed:(Update*)update;
@end