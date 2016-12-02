//
//  MainViewController.m
//  BusinessCard
//
//  Created by Snos on 2016/11/27.
//  Copyright © 2016年 Snow. All rights reserved.
//

#import "MainViewController.h"
#import "ServerCommunicator.h"
#import "DataManager.h"

@interface MainViewController (){
    ServerCommunicator *server;
    DataManager *dataManager;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    server = [ServerCommunicator sharedInstance];
    dataManager = [DataManager newData];
    /*
    [server doPostJobWithURLString:GETFRIEND_URL parameters:@{@"id":@"1"} data:nil completion:^(NSError *error, id result) {
        if (error) {
            NSLog(@"Retrive Messages Fail: %@",error);
            return;
        }
        dataManager.friendArray = result[MESSAGES_KEY];
        if (dataManager.friendArray.count == 0) {
            NSLog(@"No new message. Do noting here.");
            return;
        }
        NSLog(@"%i",dataManager.friendArray.count);

    }];
    */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addBtn:(id)sender {
    NSDictionary *parameters = @{@"id":@"1",
                                 @"friend_id":@""};
    [server doPostJobWithURLString:ADDFRIEND_URL parameters:parameters data:nil completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
