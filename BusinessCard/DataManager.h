//
//  DataManager.h
//  BusinessCard
//
//  Created by Snos on 2016/11/27.
//  Copyright © 2016年 Snow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

@property(strong,nonatomic) NSMutableArray *friendArray;
@property(strong,nonnull) NSString *userId;

+(instancetype) newData;


@end
