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
    ServerCommunicator *server = [ServerCommunicator sharedInstance];
    //[server doPostJobWithURLString:SENDMESSAGE_URL parameters:<#(NSDictionary *)#> data:nil completion:nil]
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
