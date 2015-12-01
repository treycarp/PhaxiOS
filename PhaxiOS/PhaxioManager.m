//
//  PhaxioManager.m
//  PhaxiOS
//
//  Created by Trey Carpenter on 11/28/15.
//  Copyright © 2015 Trey Carpenter. See included LICENSE file.
//

#import "PhaxioManager.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import <AFNetworking/AFURLRequestSerialization.h>

@implementation PhaxioManager

static NSString *PhaxioBaseURL = @"https://api.phaxio.com/v1/";
static NSString *PhaxioSendURL = @"send";
static NSString *PhaxioStatusURL = @"faxStatus";
static NSString *PhaxioAPIKey = @"api_key";
static NSString *PhaxioAPISecretKey = @"api_secret";

static NSString *PMAPIKey;
static NSString *PMAPISecret;

+ (instancetype)sharedInstance{
    static PhaxioManager *sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PhaxioManager alloc] init];
    });
    
    return sharedInstance;
}

/*!
    @brief Sets the api key and secret key.
    @discussion This method will set the api key and secret key to be used when working with Phaxio.  <b> You must call this method before any other methods for the service to function correctly.</b>
    @param apiKey The api key for your account.
    @param apiSecret The secret key for your account.
 */

+ (void)setPMAPIKey:(NSString *)apiKey andPMAPISecret:(NSString *)apiSecret{
    PMAPIKey = apiKey;
    PMAPISecret = apiSecret;
}


/*!
 @brief Sends a fax.
 @discussion This method will send a file to be faxed.
 @param faxData The data of the file to be faxed.
 @param type The type of file being sent (pdf, doc, docx, etc).
 @param phoneNumber The number you would like the fax to be sent to.
 @param options Dictionary of options (ex. callback url, etc).
 @param completion Success block that is called when the network request finishes.  Returns a response object.
 @param failure Failure block that is called if the request fails. Returns a NSError.
 */
- (void)send:(NSData *)faxData ofType:(NSString *)type toNumber:(NSString *)phoneNumber withOptions:(NSDictionary *)options completion:(void (^)(id responseObject))completion failure:(void (^)(NSError *error))failure{
    
    [self verifyKeys];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:phoneNumber forKey:@"to"];
    [params setValue:PMAPIKey forKey:PhaxioAPIKey];
    [params setValue:PMAPISecret forKey:PhaxioAPISecretKey];
    if([options objectForKey:CALLBACK_URL]){
        [params setValue:[options objectForKey:CALLBACK_URL] forKey:CALLBACK_URL];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [manager POST:[NSString stringWithFormat:@"%@%@", PhaxioBaseURL, PhaxioSendURL] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:faxData name:@"filename" fileName:[NSString stringWithFormat:@"faxFileName.%@", type] mimeType:@"application/octet-stream"];
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completion(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(error);
    }];
}

/*!
 @brief Gets a fax status.
 @discussion This method will retrieve the status of a fax with the id you've specified.
 @param faxId The fax id you'd like a status of.
 @param completion Completion block when the request is completed with the response object.
 @param failure Failure block that is called if the request fails. Returns a NSError.
 */
- (void)faxStatusForId:(NSString *)faxId completion:(void (^)(id responseObject))completion failure:(void (^)(NSError *error))failure{
    
    [self verifyKeys];
    
    NSDictionary *params = @{ @"id" : faxId, PhaxioAPIKey : PMAPIKey, PhaxioAPISecretKey : PMAPISecret };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@%@", PhaxioBaseURL, PhaxioStatusURL] parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completion(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark Private Methods

- (void)verifyKeys{
    NSAssert(PMAPIKey, @"You must have an api_key set before calling a function!");
    NSAssert(PMAPISecret, @"You must have an api_secret value set before calling a function!");
}


@end
