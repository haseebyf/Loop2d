//
//  CCButton.m
//  iPhoneApp
//
//  Created by Haseeb Yousaf on 11/27/10.
//  Copyright 2010 Penta::Loop inc. All rights reserved.
//

#import "CCButton.h"


@interface CCButton(private)
-(id)initAtPosition:(CGPoint)position;
-(CCSprite*)spriteForState:(CCButtonState)state;
-(void)setButtonState:(CCButtonState)state;
-(void)updateGui;
@end

@implementation CCButton

@synthesize enabled;
//=========================================================================
#pragma mark CONSTANTS
//=========================================================================
static const int ddLogLevel = APP_LOG_LEVEL;
#define kCurrentSpriteTag 0x00101
//=========================================================================
#pragma mark CUSTOM GETTER/SETTERS
//=========================================================================
-(void)setEnabled:(BOOL)newValue {
	enabled = newValue;
	if (enabled) {
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:YES];
	} else {
		[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	}
}


-(void)setContentSize:(CGSize)newSize {
	[super setContentSize:newSize];
	[self updateGui];
}


-(void)setScaleX:(float)aScale {
	[super setScaleX:aScale];
	//[self updateGui];
}

-(void)setScaleY:(float)aScale {
	[super setScaleY:aScale];
	//[self updateGui];
}


-(void)setVisible:(BOOL)isVisible {
	if (isVisible) {
		[super setVisible:isVisible];
		if (_lastEnabledStateBeforeHide) {
			self.enabled = YES;
		}
	} else {
		_lastEnabledStateBeforeHide = self.enabled;
		[super setVisible:isVisible];
		self.enabled = NO;
	}
}

//=========================================================================
#pragma mark -
#pragma mark INITIALIZATION
//=========================================================================
//**************************************************************
+(CCButton*)buttonWithFrame:(CGRect)rect {
	CCButton *button = [self node];
	[button setContentSize:rect.size];
	button.position = CGPointMake(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2);
	[button loadDefaults];
	return button;
}


//**************************************************************
-(void)loadDefaults {
	// Setting default state sprites
	backgroundSprite = [CCSprite node];
	[backgroundSprite setColor:ccRED];
	[self addChild:backgroundSprite z:-1];
	// Setting default state
	self.enabled = YES;
	[self setButtonState:CCButtonStateNormal];
	// Update gui
	[self updateGui];
}



//=========================================================================
#pragma mark -
#pragma mark Button state management methods
//=========================================================================
//**************************************************************
-(void)updateGui {
	CGSize buttonFrame = self.contentSize;
	CGPoint buttonCenter = CGPointMake(buttonFrame.width / 2, buttonFrame.height / 2);
	if (backgroundSprite) {
		[backgroundSprite setTextureRect:CGRectMake(0, 0, buttonFrame.width, buttonFrame.height)];
		backgroundSprite.position = buttonCenter;
	}
	
	CCSprite* currentSprite = (CCSprite*)[self getChildByTag:kCurrentSpriteTag];
	if (currentSprite) {
		[currentSprite scaleToSize:buttonFrame fitType:CCScaleFitAspectFill];
		currentSprite.position = buttonCenter;
	}
}


//**************************************************************
-(void)setButtonState:(CCButtonState)state {
	currentState = state;
	//Log(@"button state: %d tag:%d",state,self.tag);
	CCSprite* newSprite = nil;
	switch (state) {
		case CCButtonStateNormal: {
			newSprite = [self spriteForState:CCButtonStateNormal];
		}
			break;
		case CCButtonStateHighlighted: {
			newSprite = [self spriteForState:CCButtonStateHighlighted];
			if (!newSprite) {
				newSprite = [self spriteForState:CCButtonStateNormal];
			}
		}
			break;
		case CCButtonStateDisabled: {
			newSprite = [self spriteForState:CCButtonStateDisabled];
			if (!newSprite) {
				newSprite = [self spriteForState:CCButtonStateNormal];
			}
		}
			break;
		default:
			break;
	}
	// Change the sprite
	CCSprite* currentSprite = (CCSprite*)[self getChildByTag:kCurrentSpriteTag];
	if(newSprite != currentSprite) {
		if (currentSprite) {
			[self removeChild:currentSprite cleanup:NO];
		}
		if(newSprite) {
			newSprite.position = CGPointMake(self.contentSize.width / 2, self.contentSize.height / 2);
			[self addChild:newSprite z:0 tag:kCurrentSpriteTag];
		}	
	}
	// Update GUI
	[self updateGui];
}


-(void)setSprite:(CCSprite*)sprite forState:(CCButtonState)state {
	if(!buttonSprites) {
		buttonSprites = [[NSMutableDictionary alloc] init];
	}
	
	if (sprite != nil) {
		[buttonSprites setValue:sprite forKey:[NSString stringWithFormat:@"%d",state]];
	}
	[self setButtonState:currentState];
}

-(CCSprite*)spriteForState:(CCButtonState)state {
	CCSprite* result = nil;
	if(buttonSprites) {
		result = [buttonSprites valueForKey:[NSString stringWithFormat:@"%d",state]];
	}
	return result;
}


-(void)sizeToFit {
	CCSprite* currentSprite = (CCSprite*)[self getChildByTag:kCurrentSpriteTag];
	if (currentSprite) {
		CGSize spriteSize = currentSprite.contentSize;
		[self setContentSize:spriteSize];
		//[currentSprite scaleToSize:buttonFrame fitType:CCScaleFitAspectFill];
	}
}

//=========================================================================
#pragma mark -
#pragma mark Events
//=========================================================================
//*************************************************************************
-(void)addTarget:(id)target action:(SEL)action forEvent:(CCButtonEvent)event {
	switch (event) {
		case CCButtonEventTouchDownInside: {
			touchDownInsideTarget = target;
			touchDownInsideSelector = action;
		}
			break;
		case CCButtonEventTouchUpInside: {
			touchUpInsideTarget = target;
			touchUpInsideSelector = action;
		}
			break;
		default:
			break;
	}
}



//=========================================================================
#pragma mark -
#pragma mark Touch tracking
//=========================================================================
//*************************************************************************
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint location = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
	//Log(@"x:%f  y:%f tag:%d, position:%f %f",location.x,location.y,self.tag,self.position.x, self.position.y);
	//Do a fast rect check before doing a circle hit check:
	CGRect buttonFrame = [self boundingBox];
//	CGPoint pt =  [self convertToWorldSpace:mk];
	//CGRect rect = CGRectMake(pt.x, pt.y, [currentSprite boundingBox].size.width, [currentSprite boundingBox].size.height);
	DDLogVerbose(@"rect:%@ point:%@ tag:%d res:%d",[NSValue valueWithCGRect:buttonFrame],[NSValue valueWithCGPoint:location],self.tag,CGRectContainsPoint(buttonFrame, location));
	if(!CGRectContainsPoint(buttonFrame, location)){
		return NO;
	} else {
		// **** Button is touched ***
		// Change button state
		[self setButtonState:CCButtonStateHighlighted];
		// Call selector
		DDLogVerbose(@"ButtonDown");
		if (touchDownInsideTarget && touchDownInsideSelector) {
			if ([touchDownInsideTarget respondsToSelector:touchDownInsideSelector]) {
				[touchDownInsideTarget performSelectorOnMainThread:touchDownInsideSelector withObject:self waitUntilDone:YES];
			} else {
				DDLogWarn(@"WARNING: %@",@"target does not respond to selector");
			}
		}
		return YES;
	}	
	return NO;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint location = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
	//Log(@"x:%f  y:%f %d",location.x,location.y,CGRectContainsPoint(frame, location));
	//Do a fast rect check before doing a circle hit check:
	CCSprite* currentSprite = (CCSprite*)[self getChildByTag:kCurrentSpriteTag];
	if(currentSprite) {
		CGPoint mk = [currentSprite boundingBox].origin;
		CGPoint pt =  [self convertToWorldSpace:mk];
		CGRect rect = CGRectMake(pt.x, pt.y, [currentSprite boundingBox].size.width, [currentSprite boundingBox].size.height);
		if(!CGRectContainsPoint(rect, location)){
			[self setButtonState:CCButtonStateHighlighted];
		} else {
			// **** Button is untouched ***
			// Change button state
			[self setButtonState:CCButtonStateNormal];
		}
	}
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	// **** Button is touched ***
	// Change button state
	[self setButtonState:CCButtonStateNormal];
	// Call selector
	DDLogVerbose(@"ButtonUp");
	if (touchUpInsideTarget && touchUpInsideSelector) {
		if ([touchUpInsideTarget respondsToSelector:touchUpInsideSelector]) {
			[touchUpInsideTarget performSelectorOnMainThread:touchUpInsideSelector withObject:self waitUntilDone:YES];
		} else {
			DDLogWarn(@"WARNING: %@",@"target does not respond to selector");
		}
	}
}

- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
	[self ccTouchEnded:touch withEvent:event];
}


//=========================================================================
#pragma mark -
#pragma mark Memory management
//=========================================================================
//**************************************************************
-(void)onExit {
	LogStart;
	self.enabled = NO;
	LogEnd;
}





-(void)dealloc {
	LogStart;
	self.enabled = NO;
	if (buttonSprites) {
		safeRelease(buttonSprites);
	}
	[super dealloc];
	LogEnd;
}

@end
