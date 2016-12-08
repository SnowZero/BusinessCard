//
//  LoginViewController.m
//  BusinessCard
//
//  Created by Snos on 2016/12/4.
//  Copyright © 2016年 Snow. All rights reserved.
//

#import "LoginViewController.h"
#import "ServerCommunicator.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "DataManager.h"

@interface LoginViewController  ()<FBSDKLoginButtonDelegate>{
    DataManager *dataManager;
    ServerCommunicator *server;

    NSString *fbUid;
}
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *fbLoginBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataManager = [DataManager newData];
    server = [ServerCommunicator new];
    
    _fbLoginBtn.delegate = self;
    //_fbLoginBtn.readPermissions =@[@"public_profile", @"email", @"user_friends"];
    
    if ([FBSDKAccessToken currentAccessToken] !=nil) {
        fbUid = [[FBSDKAccessToken currentAccessToken] userID];
        NSLog(@"uid:%@",fbUid);
        [self loginToMainVc];
    }else{
        _fbLoginBtn.readPermissions =@[@"public_profile", @"email", @"user_friends"];
    }
  

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error;
{
    // 舊式的寫法
    NSArray *permissions = [[NSArray alloc] initWithObjects:
                            @"public_profile", @"email", @"user_friends", nil];
    //    最新的寫法
    //    loginButton.readPermissions =
    //    @[@"public_profile", @"email", @"user_friends"];
    
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logOut];
    if (error) {
        // description:顯示error原因
        NSLog(@"Process error:%@",error.description);
    } else if (result.isCancelled) {
        NSLog(@"Cancelled");
    } else {
        NSLog(@"Logged in %@", result.token.userID);
        fbUid = result.token.userID;
        [self loginToMainVc];
    }
    
    
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    NSLog(@"登出成功");
}

-(BOOL)loginButtonWillLogin:(FBSDKLoginButton *)loginButton
{
    return YES;
}

-(void)loginToMainVc{
    
    dataManager.fbUid = fbUid;
    [self checkMember];

}


-(void)checkMember{
    [server doPostJobWithURLString:CHECK_MEMBER_URL parameters:@{@"UID":dataManager.fbUid,@"1":@"2"} data:nil completion:^(NSError *error, id result) {
        if (error) {
            NSLog(@"error:%@",error);
        }else{
            NSLog(@"%@",result[@"result"]);
            dataManager.userId = result[@"result"];
            
            UIViewController *qrVc = [self.storyboard instantiateViewControllerWithIdentifier:@"TabC"];
            // 跳到下一頁
            [self presentViewController:qrVc animated:YES completion:nil];
        }
    }];
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
