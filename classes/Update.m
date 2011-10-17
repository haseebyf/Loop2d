//
//  Playlist.m
//  iPhoneApp
//
//  Created by Haseeb Yousaf on 11/23/10.
//  Copyright 2010 Penta::Loop inc. All rights reserved.
//

#import "Update.h"


@implementation Update

@synthesize version;
@synthesize downloadUrl;

- (void)dealloc
{
	[version release];
	version = nil;
	[downloadUrl release];
	downloadUrl = nil;

	[super dealloc];
}

@end
