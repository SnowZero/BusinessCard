//
//  ViewController.m
//  BusinessCard
//
//  Created by Snos on 2016/11/10.
//  Copyright © 2016年 Snow. All rights reserved.
//

#import "ViewController.h"
#import "ServerCommunicator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
}

- (IBAction)testBtn:(id)sender {
    ServerCommunicator *server = [ServerCommunicator sharedInstance];
    NSDictionary *parameters = @{@"number":@"123",
                                 @"password":@"456",
                                 @"e-mail":@"789"};
    
    [server doPostJobWithURLString:RETRIVEMESSAGES_URL parameters:parameters data:nil completion:^(NSError *error, id result) {
        if (error) {
            NSLog(@"Retrive Messages Fail: %@",error);
            return;
        }
        NSArray *items = result[MESSAGES_KEY];
        if (items.count == 0) {
            NSLog(@"No new message. Do noting here.");
            return;
        }
        for (NSDictionary *tmp in items) {
            NSLog(@"number : %@", tmp[@"number"]);
        }
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
