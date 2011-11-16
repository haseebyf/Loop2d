//
//  untitled.h
//  Loop2d
//
//  Created by Haseeb Yousaf on 11/12/11.
//  Copyright 2011 Penta::Loop inc. All rights reserved.
//

#import "cocos2d.h"

typedef enum
{
	CCScaleFitFull,
	CCScaleFitAspectFit,
	CCScaleFitAspectFill,
} CCScaleFit;

@interface CCNode (Scaling)

-(void)scaleToSize:(CGSize)size fitType:(CCScaleFit)fitType;

@end