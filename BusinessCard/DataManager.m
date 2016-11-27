//
//  DataManager.m
//  BusinessCard
//
//  Created by Snos on 2016/11/27.
//  Copyright © 2016年 Snow. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

static DataManager *dataManager = nil;

+(instancetype)newData{
    if (dataManager == nil) {
        dataManager = [DataManager new];
    }
    return dataManager;
}

@end
