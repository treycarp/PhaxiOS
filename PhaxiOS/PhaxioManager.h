//
//  PhaxioManager.h
//  PhaxiOS
//
//  Created by Trey Carpenter on 11/28/15.
//  Copyright © 2015 Trey Carpenter. See included LICENSE file.
//

#import <Foundation/Foundation.h>

#define CALLBACK_URL @"callback_url"

@interface PhaxioManager : NSObject

+ (instancetype)sharedInstance;
+ (void) setPMAPIKey:(NSString *)apiKey andPMAPISecret:(NSString *)apiSecret;

- (void)send:(NSData *)faxData ofType:(NSString *)type toNumber:(NSString *)phoneNumber withOptions:(NSDictionary *)options completion:(void (^)(id responseObject))completion failure:(void (^)(NSError *error))failure;
- (void)faxStatusForId:(NSString *)faxId completion:(void (^)(id responseObject))completion failure:(void (^)(NSError *error))failure;
@end
