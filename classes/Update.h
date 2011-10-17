//
//  Playlist.h
//  iPhoneApp
//
//  Created by Haseeb Yousaf on 11/23/10.
//  Copyright 2010 Penta::Loop inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Update : NSObject {
	NSString* version;
	NSString* downloadUrl;
}

@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *downloadUrl;

@end
