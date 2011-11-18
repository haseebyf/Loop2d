//
//  CCButton.h
//  iPhoneApp
//
//  Created by Haseeb Yousaf on 11/27/10.
//  Copyright 2010 Penta::Loop inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

//=========================================================================
#pragma mark -
#pragma mark Enumrations
//=========================================================================
typedef enum _CCButtonEvent {
	CCButtonEventTouchDownInside,
	CCButtonEventTouchUpInside,
	CCButtonEventTouchesCanceled
} CCButtonEvent;

typedef enum _CCButtonState {
	CCButtonStateNormal,
	CCButtonStateHighlighted,
	CCButtonStateDisabled
} CCButtonState;

//=========================================================================
#pragma mark -
#pragma mark Interface
//=========================================================================
@interface CCButton : CCSprite <CCTargetedTouchDelegate> {

	// UI
	CCSprite* backgroundSprite;
	
	// Selectors
	SEL touchDownInsideSelector;
	id touchDownInsideTarget;
	
	SEL touchUpInsideSelector;
	id touchUpInsideTarget;
	
	// State
	NSDictionary* buttonSprites;
	CCButtonState currentState;
	BOOL enabled;
	BOOL _lastEnabledStateBeforeHide;
}

@property (nonatomic, assign, setter=setEnabled:) BOOL enabled;
@property (nonatomic, readonly) BOOL active;
@property (nonatomic, assign) BOOL isHoldable;
@property (nonatomic, assign) BOOL isToggleable;


+(CCButton*)buttonWithFrame:(CGRect)rect;

-(void)addTarget:(id)target action:(SEL)action forEvent:(CCButtonEvent)event;
-(void)setSprite:(CCSprite*)sprite forState:(CCButtonState)state;

-(void)sizeToFit;

@end
