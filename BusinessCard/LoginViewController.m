//
//  LoginViewController.m
//  BusinessCard
//
//  Created by Snos on 2016/12/4.
//  Copyright © 2016年 Snow. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController  ()<FBSDKLoginButtonDelegate>
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *fbLoginBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _fbLoginBtn.delegate = self;
    _fbLoginBtn.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];
    
    if ([FBSDKAccessToken currentAccessToken] !=nil) {
        
    }else{
        //_fbLoginBtn.readPermissions = [@"public_profile",@"email",@"user_friends"];
    }
}
- (IBAction)facebookLoin:(id)sender {
    // 這個不需要了
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
    
    [login
     logInWithReadPermissions: permissions
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         
         if (error) {
             // description:顯示error原因
             NSLog(@"Process error:%@",error.description);
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in %@", result.token.userID);
         }
         
     }];
    
    
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    NSLog(@"登出成功");
}

-(BOOL)loginButtonWillLogin:(FBSDKLoginButton *)loginButton
{
    return YES;
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
