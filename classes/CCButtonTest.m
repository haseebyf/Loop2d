//
//  CCButtonTest.m
//  Loop2d
//
//  Created by Haseeb Yousaf on 11/12/11.
//  Copyright 2011 Penta::Loop inc. All rights reserved.
//

#import "CCButtonTest.h"

#import "CCButton.h"


@implementation CCButtonTest
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CCButtonTest *layer = [CCButtonTest node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {	
		CCButton* button = [CCButton buttonWithFrame:CGRectMake(400, 400, 100, 100)];
		[self addChild:button];
		[button setSprite:[CCSprite spriteWithFile:@"Icon@2x.png"] forState:CCButtonStateNormal];
		[button sizeToFit];
		[button runAction:[CCScaleTo actionWithDuration:10 scale:3]];
		//button = [CCButton buttonWithFrame:CGRectMake(350, 350, 10, 10)];
		//[self addChild:button];
		//button.enabled = NO;
		
	}
	return self;
}

@end
