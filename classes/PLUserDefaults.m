//
//  Created by Haseeb Yousaf on 24/12/09.
//  Copyright 2009 PentaLoop. All rights reserved.
//

#import "PLUserDefaults.h"

@implementation PLUserDefaults
//=========================================================================
#pragma mark -
#pragma mark CONSTANTS
//=========================================================================


//=========================================================================
#pragma mark -
#pragma mark SINGLETON METHODS
//=========================================================================
SYNTHESIZE_SINGLETON_FOR_CLASS(PLUserDefaults);


//=========================================================================
#pragma mark -
#pragma mark INITIALIZATION
//=========================================================================
//************************************************************
-(id)init {
	self = [super init];
	return self;
}


//=========================================================================
#pragma mark -
#pragma mark NSString values
//=========================================================================
//*************************************************************************
- (NSString*)stringForKey:(NSString *)key {
	return [self stringForKey:key defaultValue:nil];
}
//*************************************************************************
- (NSString*)stringForKey:(NSString *)key defaultValue:(NSString*)defaultValue {
	NSString *value = [super objectForKey:key];
	return (value != nil) ? value : defaultValue;
}
//*************************************************************************
- (void)setString:(NSString*)value forKey:(NSString *)key {
	[super setObject:value forKey:key];
}


//=========================================================================
#pragma mark -
#pragma mark BOOL values
//=========================================================================
//*************************************************************************
- (BOOL)boolForKey:(NSString *)key {
	return [self boolForKey:key defaultValue:YES];
}

- (BOOL)boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue {
	return [super objectForKey:key] ? [super boolForKey:key] : defaultValue;
}

- (void)setBool:(BOOL)value forKey:(NSString *)key {
	[super setBool:value forKey:key];
}


//=========================================================================
#pragma mark -
#pragma mark Integer values
//=========================================================================
//******************************************************************
- (BOOL)integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue {
	NSNumber* number = [self numberValueForKey:key];
	if (number) {
		return  [number intValue];
	} else {
		return defaultValue;
	}
}

//=========================================================================
#pragma mark -
#pragma mark Integer values
//=========================================================================
//******************************************************************
-(NSValue*)valueForKey:(NSString *)key defaultValue:(NSValue*)defaultValue {
	NSNumber* val = [self valueForKey:key];
	if (val) {
		return  val;
	} else {
		return defaultValue;
	}
}

//=========================================================================
#pragma mark -
#pragma mark Array values
//=========================================================================
//*************************************************************************
- (NSMutableArray*)arrayForKey:(NSString *)key {
	id result = [super objectForKey:key];
	return result;
}

- (void)setArray:(NSMutableArray*)value forKey:(NSString *)key {
	[super setObject:value forKey:key];
}


//*************************************************************************
- (NSMutableDictionary*)dictForKey:(NSString *)key {
	id result = [super objectForKey:key];
	return result;
}

- (void)setDict:(NSDictionary*)value forKey:(NSString *)key {
	[super setObject:value forKey:key];
}

//=========================================================================
#pragma mark -
#pragma mark Object values
//=========================================================================
//******************************************************************
-(void)setObject:(id)value forKey:(NSString *)defaultName {
	if (value) {
		if([value conformsToProtocol:@protocol(NSCoding)]){
			NSData *newData = [NSKeyedArchiver archivedDataWithRootObject:value];
			[super setObject:newData forKey:defaultName];
		} else {
			[super setObject:value forKey:defaultName];
		}
	}
}


-(id)objectForKey:(NSString *)defaultName {
	id data = [super objectForKey:defaultName];
	if ([data isKindOfClass:[NSData class]]) {
		@try {
			data = [NSKeyedUnarchiver unarchiveObjectWithData:data];
		}
		@catch (NSException * e) {
			// Data is not archived object
		}
	}	
	return data;
}

@end
