//
//  main.m
//  Loop
//
//  Created by Haseeb Yousaf on 9/9/11.
//  Copyright Penta::Loop inc. 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "wax.h"
#import "wax_http.h"
#import "wax_json.h"
#import "wax_xml.h"
#import "lauxlib.h"

int main(int argc, char *argv[]) {
	NSAutoreleasePool *pool = [NSAutoreleasePool new];
	
	
	[[ApplicationManager sharedApplicationManager] initializeBaseVersionScripts];
	[[ApplicationManager sharedApplicationManager] beginUpdate];
	wax_start("", luaopen_wax_http, luaopen_wax_json, luaopen_wax_xml, nil);
	//[[ApplicationManager sharedApplicationManager] loadScripts];
	/*
	Class klass = NSClassFromString(@"AppDelegateLua");
	NSString* delegateNameStr = @"AppDelegate";
	if ([klass instancesRespondToSelector:@selector(application:didFinishLaunchingWithOptions:)]) {
		delegateNameStr = @"Main";
	}	
	 */
	int retVal = UIApplicationMain(argc, argv, nil, @"AppDelegate");
    [pool release];
    return retVal;
}
