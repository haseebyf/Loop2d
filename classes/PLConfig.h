//
//  GameConfig.h
//  Loop
//
//  Created by Haseeb Yousaf on 9/9/11.
//  Copyright Penta::Loop inc. 2011. All rights reserved.
//

#ifndef __PLCONFIG_H
#define __PLCONFIG_H


// ============================================================
#pragma mark -
#pragma mark Cocos2d configuration
// ============================================================

//
// Supported Autorotations:
//		None,
//		UIViewController,
//		CCDirector
//
#define kGameAutorotationNone 0
#define kGameAutorotationCCDirector 1
#define kGameAutorotationUIViewController 2

//
// Define here the type of autorotation that you want for your game
//

// 3rd generation and newer devices: Rotate using UIViewController. Rotation should be supported on iPad apps.
// TIP:
// To improve the performance, you should set this value to "kGameAutorotationNone" or "kGameAutorotationCCDirector"
#if defined(__ARM_NEON__) || TARGET_IPHONE_SIMULATOR
#define GAME_AUTOROTATION kGameAutorotationUIViewController

// ARMv6 (1st and 2nd generation devices): Don't rotate. It is very expensive
#elif __arm__
#define GAME_AUTOROTATION kGameAutorotationNone


// Ignore this value on Mac
#elif defined(__MAC_OS_X_VERSION_MAX_ALLOWED)

#else
#error(unknown architecture)
#endif

// ============================================================
#pragma mark -
#pragma mark Logger configuration
// ============================================================
#ifndef DEBUG
	#define APP_LOG_LEVEL LOG_LEVEL_OFF
#else
	#define APP_LOG_LEVEL LOG_LEVEL_VERBOSE;
#endif

#endif // __PLCONFIG_H

