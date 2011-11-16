//
//  Util.h
//  SSP.Cocoa
//
//  Created by Mikhail Burilov on 4/8/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <dlfcn.h>

#define IS_NEGATIVE(X) X < 0.0f
#define KEYBOARD_SHOWING_TIME 0.32f

BOOL GSFontAddFromFile(const char * path);

typedef struct AccelerationStruct {
	UIAccelerationValue x;
	UIAccelerationValue y;
	UIAccelerationValue z;
} AccelerationStruct;

@interface RectObj : NSObject {
	CGRect rect;
}
@property(nonatomic) CGRect rect;
@end

@interface KeyValuePair : NSObject {
	NSString* key;
	id value;
}
@property(nonatomic, retain) NSString* key;
@property(nonatomic, retain) id value;
+(id) pairWithKey:(NSString*) _key value:(id) _value;
@end



@interface Helper : NSObject {
}
+(UIColor*) colorWithR:(int) r G:(int) g B:(int) b;
+(UIColor*) colorWithR:(int) r G:(int) g B:(int) b A:(float) a;
+(UIColor*) systemBlueFontColor;
+(CGRect) standartFrame;
+(CGRect) landscapeStandartFrame;
+(UIImageView*) createViewWithImage:(NSString*) imgName;
+(bool)fileExistsWithPath:(NSString*) path;
+(bool)folderExistsWithPath:(NSString*) path;

+(bool) createEmptyFileWithPath:(NSString*) path;
+(void) sendEmailTo:(NSString*) to withSubject:(NSString*) subject withBody:(NSString*) body;
+(UIView*) getKeyboard;
+(UIView*) view:(UIView*) container subviewWithTag:(NSInteger) tag;
+(UIView*) subviewOf:(UIView*) container withTag:(NSInteger) tag;
+(UIView*) rootViewOf:(UIView*) view;

/*Shorting*/
+(void) dict:(NSMutableDictionary*) dict addObject:(id) obj forKey:(NSString*) key;
+(NSArray*) getImages:(NSArray*) namesArray;
+(NSArray*) getImageArray:(NSString*)firstArg, ... ;

+(NSString*) infinitySymbol;
+(void) exchange:(NSMutableArray*)array objectAtIndex:(NSInteger) index to:(id) newValue;

+(void) prepareAnimation: (NSTimeInterval) duration;
+(void) commitAnimation;

+(UILabel*) labelWithFrame:(CGRect) frame withFont:(UIFont*) font withText:(NSString*) text;
+(bool) fileExistsWithName:(NSString*) name;
+(BOOL) isZeroRect:(CGRect) rect;
+(BOOL) rect:(CGRect) rect1 isInterseted:(CGRect) rect2;
+(UIImageView*) getUIImageViewWithFrame:(CGRect) frame withBImage:(UIImage*) img;
+(bool) setProp:(id*) object to:(id) value;
+(void) killObject:(id*) object;
+(NSString*) resourcePath:(NSString*) fileName;
+ (NSString *)applicationDocumentsDirectory;

+(void)playShortSound:(NSString*)soundFileName;
@end
