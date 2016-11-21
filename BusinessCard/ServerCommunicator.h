//
//  ServerCommunicator.h
//  BusinessCard
//
//  Created by Snos on 2016/11/10.
//  Copyright © 2016年 Snow. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DATA_KEY    @"data"


#define BASE_URL @"http://203.64.42.80/webapp/ap103/"
#define SENDMESSAGE_URL [BASE_URL stringByAppendingPathComponent:@"sendMessage.php"]
#define UPDATEDEVICETOKEN_URL [BASE_URL stringByAppendingPathComponent:@"updateDeviceToken.php"]

typedef void(^DoneHeandler)(NSError *error,id result);

@interface ServerCommunicator : NSObject
+ (instancetype) sharedInstance;

- (void) doPostJobWithURLString:(NSString*) urlString
                     parameters:(NSDictionary*)parameters
                           data:(NSData*) data
                     completion:(DoneHeandler) done;

@end
