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
#import "BusinessCard-Swift.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface MainViewController ()<AVCaptureMetadataOutputObjectsDelegate>{
    ServerCommunicator *server;
    DataManager *dataManager;
    CIImage *qrcodeImage;
    
    AVCaptureSession *aptureSession;
    AVCaptureVideoPreviewLayer *videoPreviewLayer;
    NSString *myId;
    

    __weak IBOutlet UITextField *userID;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgQRcode;

@end

@implementation MainViewController
- (IBAction)resetUserID:(id)sender {
    myId = userID.text;
    dataManager.userId = myId;
    
    NSString *codeData = [NSString stringWithFormat:@"BusinessCard:%@",myId];
    NSData *data = [codeData dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"Q" forKey:@"inputCorrectionLevel"];
    qrcodeImage = filter.outputImage;
    _imgQRcode.image = [UIImage imageWithCIImage:qrcodeImage];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [userID addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];

    server = [ServerCommunicator sharedInstance];
    dataManager = [DataManager newData];
    myId = dataManager.userId;
    if (qrcodeImage == nil) {
        NSString *codeData = [NSString stringWithFormat:@"BusinessCard:%@",myId];
        NSData *data = [codeData dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
        CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        [filter setValue:data forKey:@"inputMessage"];
        [filter setValue:@"Q" forKey:@"inputCorrectionLevel"];
        qrcodeImage = filter.outputImage;
        _imgQRcode.image = [UIImage imageWithCIImage:qrcodeImage];
        [self displayQRCodeImage];
    }
    


}
-(void)displayQRCodeImage{
    //CGFloat scaleX = _imgQRCode.frame.size.width / _qrcodeImage.extent().size.width
    CIImage *transformedImage = [qrcodeImage imageByApplyingTransform:CGAffineTransformMakeScale(3, 3)];
    _imgQRcode.image = [UIImage imageWithCIImage:transformedImage];
    

}


    
    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addBtn:(id)sender {
    NSDictionary *parameters = @{@"id":myId,
                                 @"friend_id":@""};
    [server doPostJobWithURLString:ADDFRIEND_URL parameters:parameters data:nil completion:nil];
}

-(void)addFrend:(NSString *)friendId{
    NSLog(@"%@",friendId);
    NSDictionary *parameters = @{@"id":myId,
                                 @"friend_id":friendId};
    //自己增加好友
    [server doPostJobWithURLString:ADDFRIEND_URL parameters:parameters data:nil completion:nil];
    //送出邀請給對方
    parameters= @{@"id":friendId,
                  @"friend_id":myId};
    [server doPostJobWithURLString:ADDFRIEND_URL parameters:parameters data:nil completion:nil];
    [self showAlert];
}

- (IBAction)readQRcode:(id)sender {
    QRScannerController *qrVc = (QRScannerController*)[self.storyboard instantiateViewControllerWithIdentifier:@"qrVc"];
    // 跳到下一頁
    qrVc.mainVc = self;
    
    [self presentViewController:qrVc animated:YES completion:nil];
}



-(void)showAlert{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"邀請好友" message:@"邀請好友成功！" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    //將按鈕加到 alert 上面
    [alertController addAction:ok];
    //將 alert 呈現在畫面上
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)textFieldDone:(UITextField*)textField
{
    [textField resignFirstResponder];
}

- (IBAction)logout:(id)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logOut];
    [self.presentingViewController  dismissViewControllerAnimated:YES completion:nil];
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
