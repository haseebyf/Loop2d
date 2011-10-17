//
//  Created by Haseeb Yousaf on 24/12/09.
//  Copyright 2009 PentaLoop. All rights reserved.
//

@interface PLUserDefaults : NSUserDefaults {
}
+(PLUserDefaults*)sharedPLUserDefaults;

// NSString values
- (NSString*)stringForKey:(NSString *)key;
- (NSString*)stringForKey:(NSString *)key defaultValue:(NSString*)defaultValue;
- (void)setString:(NSString*)value forKey:(NSString *)key;
// bool Values
- (BOOL)boolForKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (void)setBool:(BOOL)value forKey:(NSString *)key;
// Integer
- (BOOL)integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;
// Value
-(NSValue*)valueForKey:(NSString *)key defaultValue:(NSValue*)defaultValue;
// Array
- (NSMutableArray*)arrayForKey:(NSString *)key;
- (void)setArray:(NSMutableArray*)value forKey:(NSString *)key;
// Dictionary
- (NSDictionary*)dictForKey:(NSString*)key;
- (void)setDict:(NSDictionary*)value forKey:(NSString *)key;

-(void)setObject:(id)value forKey:(NSString *)defaultName;
-(id)objectForKey:(NSString *)defaultName;
@end
