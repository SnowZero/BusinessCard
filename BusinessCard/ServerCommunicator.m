//
//  ServerCommunicator.m
//  BusinessCard
//
//  Created by Snos on 2016/11/10.
//  Copyright © 2016年 Snow. All rights reserved.
//

#import "ServerCommunicator.h"
#import <AFNetworking.h>

#define BASE_URL @"http://203.64.42.80/webapp/ap103/"
#define SENDMESSAGE_URL [BASE_URL stringByAppendingPathComponent:@"sendMessage.php"]


static ServerCommunicator *_singletonCommunicator = nil;

@implementation ServerCommunicator

+(instancetype)sharedInstance{
    
    if (_singletonCommunicator == nil) {
        _singletonCommunicator = [ServerCommunicator new];
    }
    return _singletonCommunicator;
}


#pragma mark  - General Post Methods
- (void) doPostJobWithURLString:(NSString*) urlString
                     parameters:(NSDictionary*)parameters
                           data:(NSData*) data
                     completion:(DoneHeandler) done{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSLog(@"doPOST parameters:%@",jsonString);
    
    NSDictionary *finalParamters = @{@"data":jsonString};
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:urlString
       parameters:finalParamters
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    
    if(data != nil){
        [formData appendPartWithFileData:data
                                    name:@"fileToUpload"
                                fileName:@"image.jpg"
                                mimeType:@"image/jpg"];
    }
}
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
              NSLog(@"doPOST OK :%@",responseObject);
              if (done != nil) {
                  done(nil,responseObject);
              }
              
              
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"doPOST Fail :%@",error);
              if (done != nil) {
                  done(error,nil);
              }
          }];
}



@end
