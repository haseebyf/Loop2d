//
//  PLLogger.h
//
//

#import <Foundation/Foundation.h>



#define Log(fmt, ...) DDLogVerbose((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define LogStart Log("START")
#define LogEnd Log("END")
