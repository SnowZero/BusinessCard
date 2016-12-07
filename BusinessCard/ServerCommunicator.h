//
//  ServerCommunicator.h
//  BusinessCard
//
//  Created by Snos on 2016/11/10.
//  Copyright © 2016年 Snow. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DATA_KEY    @"data"
#define MESSAGES_KEY    @"Messages"


#define BASE_URL @"http://203.64.42.80/webapp/ap103/"
#define SENDMESSAGE_URL [BASE_URL stringByAppendingPathComponent:@"sendMessage.php"]
#define UPDATEDEVICETOKEN_URL [BASE_URL stringByAppendingPathComponent:@"updateDeviceToken.php"]
#define RETRIVEMESSAGES_URL [BASE_URL stringByAppendingPathComponent:@"retriveMessages.php"]
#define ADDFRIEND_URL [BASE_URL stringByAppendingPathComponent:@"addFriend.php"]
#define GETFRIEND_URL [BASE_URL stringByAppendingPathComponent:@"getFriend.php"]
#define GET_USERDATA_URL [BASE_URL stringByAppendingPathComponent:@"getUserData.php"]
#define UPDATE_USERDATA_URL [BASE_URL stringByAppendingPathComponent:@"updateUserData.php"]
#define SET_FRIEND_URL [BASE_URL stringByAppendingPathComponent:@"waitFriend.php"]
#define CHECK_MEMBER_URL [BASE_URL stringByAppendingPathComponent:@"checkMember.php"]


typedef void(^DoneHeandler)(NSError *error,id result);

@interface ServerCommunicator : NSObject
+ (instancetype) sharedInstance;

- (void) doPostJobWithURLString:(NSString*) urlString
                     parameters:(NSDictionary*)parameters
                           data:(NSData*) data
                     completion:(DoneHeandler) done;

@end
