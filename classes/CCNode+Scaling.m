//
//  untitled.m
//  Loop2d
//
//  Created by Haseeb Yousaf on 11/12/11.
//  Copyright 2011 Penta::Loop inc. All rights reserved.
//

#import "CCNode+Scaling.h"

@implementation CCNode (Scaling)

-(void)scaleToSize:(CGSize)size fitType:(CCScaleFit)fitType
{
	CGSize targetSize = size;
	CGSize mySize = [self contentSize];
	
	float targetAspect = targetSize.width/targetSize.height;
	float myAspect = mySize.width/mySize.height;
	
	float xScale = [self scaleX];
	float yScale = [self scaleY];
	
	switch (fitType)
	{
		case CCScaleFitFull:
			xScale = targetSize.width/mySize.width;
			yScale = targetSize.height/mySize.height;
			break;
			
		case CCScaleFitAspectFit:
			if(targetAspect > myAspect)
			{
				xScale = yScale = targetSize.height/mySize.height;
			}
			else
			{
				yScale = xScale = targetSize.width/mySize.width;
			}
			break;
			
		case CCScaleFitAspectFill:
			
			if(targetAspect > myAspect)
			{
				xScale = yScale = targetSize.width/mySize.width;
			}
			else
			{
				yScale = xScale = targetSize.height/mySize.height;
			}
			break;
			
		default:
			break;
	}
	
	[self setScaleX:xScale];
	[self setScaleY:yScale];
	
}

@end