//
//  LoopAppDelegate.h
//  Loop
//
//  Created by Haseeb Yousaf on 9/9/11.
//  Copyright Penta::Loop inc. 2011. All rights reserved.
//
// http://www.cocos2d-iphone.org/
#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
