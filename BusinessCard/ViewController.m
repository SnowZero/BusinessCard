//
//  ViewController.m
//  BusinessCard
//
//  Created by Snos on 2016/11/10.
//  Copyright © 2016年 Snow. All rights reserved.
//

#import "ViewController.h"
#import "ServerCommunicator.h"
#import <FMDatabase.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController () <FBSDKLoginButtonDelegate>


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.delegate = self;
   

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

-(FMDatabase*)getFMDatabase{
    
    
    //取得可讀寫的Document路徑，
    //並指向businesscard.db資料庫檔案。
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"businesscard.db"];
    
    //透過傳遞databaseWithPath訊息給FMDatabase ，
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    
    //傳遞open訊息開啟資料庫
    //開啟MyDatabase.db資料庫，
    //若MyDatabase.db檔案不存在，
    //則會自動建立MyDatabase.db檔案，
    //而後回傳取得FMDatabase物件
    if ([db open])
    {
        //開啟成功回傳FMDatabase物件
        return db;
    }
    else
    {
        //開啟失敗回傳nil
        return nil;
    }
    
}

- (IBAction)createTable:(id)sender {
    FMDatabase *db = [self getFMDatabase];
    
    //執行CREATE TABLE指令，
    //建立member資料表，
    //其中包含id、number、password、name、mail、facebook、firend欄位，
    //而id設定為主鍵，資料型別會預設為Integer，
    //SQLite資料庫預設會自動進行流水號編號，
    //number的型別為text，password的型別為text，name的型別為text，mail的型別為text，facebook的型別為text，
    //friend的型別為text
    
    //加入  IF NOT EXISTS 會去判斷這個table是否存在，不存在就創造，存在就忽略這段
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS member (id integer primary key autoincrement, number text, password text, name text, mail text, facebook text, friend text)"];
    NSLog(@"資料表建立成功");
    
    [db close];
}
- (IBAction)insertData:(id)sender {
    
    //透過getFMDatabase訊息取得FMDatabase物件
    FMDatabase *db = [self getFMDatabase];
    
    //執行INSERT INTO指令，
    //寫入一筆資料至Users表格中
    [db executeUpdate:@"INSERT INTO member (number, password, name, mail, facebook, friend) VALUES (?,?,?,?,?,?)",
     @"1", @"1234",@"Sean", @"1234@gmail.com", @"Joe", @"Deep"];
    
    [db close];
}
- (IBAction)selectData:(id)sender {
    
    //透過getFMDatabase訊息取得FMDatabase物件
    FMDatabase *db = [self getFMDatabase];
    
    NSLog(@"xxxx");
    //執行SELECT指令，
    //選取所有資料
    FMResultSet *rs = [db executeQuery:@"SELECT number, password, name, mail, facebook, friend FROM member"];
    
    //回傳的FMResultSet物件，
    //可透過next指向下一筆資料，
    //若有下一筆資料，
    //則next訊息會回傳YES
    while ([rs next]) {
        NSString *memberMail = [rs stringForColumn:@"mail"];
        
        NSString *memberPassword = [rs stringForColumn:@"password"];
        NSLog(@"mail:%@, password:%@", memberMail, memberPassword);
        
        NSString * str = [NSString stringWithFormat:@"mail:%@, password:%@", memberMail, memberPassword];
        
        UIAlertView * alert =[[UIAlertView alloc] initWithTitle:nil
                                                        message:str
                                                       delegate:nil
                                              cancelButtonTitle:@"Close"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
    
    //傳送close訊息，
    //關閉讀取存耶的作業
    [rs close];
}
- (IBAction)updateData:(id)sender {
    
    // 透過getFMDatabase訊息取得FMDatabase物件
    FMDatabase * db = [self getFMDatabase];
    
    // 把id 2 欄位裡的名字修改成'Mike'，前面的name是修改值，後面的name是要修改的欄位
    [db executeUpdate:@"UPDATE member SET name = ? WHERE name = ?",@"Mike",@"Sean"];
    // 呼叫FMDB錯誤種類
    NSLog(@"error = %@", [db lastErrorMessage]);
    
    NSLog(@"修改成功");
    
    [db close];
}
- (IBAction)deleteData:(id)sender {
    
    FMDatabase *db = [self getFMDatabase];
    
    [db executeUpdate:@"DELETE FROM member WHERE name = ?",@"Mike"];
    
    NSLog(@"刪除成功");
    
    [db close];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
