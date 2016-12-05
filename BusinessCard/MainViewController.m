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
#import <CoreImage/CoreImage.h>
#import <AVFoundation/AVFoundation.h>

@interface MainViewController (){
    ServerCommunicator *server;
    DataManager *dataManager;
    CIImage *qrcodeImage;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgQRcode;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    server = [ServerCommunicator sharedInstance];
    dataManager = [DataManager newData];
    
    if (qrcodeImage == nil) {
        NSData *data = [@"123" dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
        CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        [filter setValue:data forKey:@"inputMessage"];
        [filter setValue:@"Q" forKey:@"inputCorrectionLevel"];
        qrcodeImage = filter.outputImage;
        _imgQRcode.image = [UIImage imageWithCIImage:qrcodeImage];
    }
    
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
