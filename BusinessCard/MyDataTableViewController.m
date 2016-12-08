//
//  MyDataTableViewController.m
//  BusinessCard
//
//  Created by Snos on 2016/12/2.
//  Copyright © 2016年 Snow. All rights reserved.
//

#import "MyDataTableViewController.h"
#import "ServerCommunicator.h"
#import "TableViewCell1.h"
#import "DataManager.h"

@interface MyDataTableViewController (){
    NSArray *arrayOfCellData;
    NSMutableArray *inputArray;
    ServerCommunicator *server;
    DataManager *dataManager;
}

@end


@implementation MyDataTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    inputArray = [NSMutableArray new];
    dataManager = [DataManager newData];
    self.tableView.contentInset = UIEdgeInsetsMake(22,0,0,0);

    
    arrayOfCellData = @[@{@"label":@"姓名"},
                        @{@"label":@"電話"},
                        @{@"label":@"市話"},
                        @{@"label":@"E-mail"},
                        @{@"label":@"地址"},
                        @{@"label":@"facebook"},
                        @{@"label":@"line"},
                        @{@"label":@"公司名稱"},
                        @{@"label":@"網址"}];
    [self startGetMyData];
}

-(void)startGetMyData{
    
    server = [ServerCommunicator sharedInstance];
    [server doPostJobWithURLString:GET_USERDATA_URL parameters:@{@"id":dataManager.userId} data:nil completion:^(NSError *error, id result) {
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
            arrayOfCellData = @[@{@"label":@"姓名",@"text":tmp[@"name"]},
                                @{@"label":@"電話",@"text":tmp[@"phone"]},
                                @{@"label":@"市話",@"text":tmp[@"loacalphone"]},
                                @{@"label":@"E-mail",@"text":tmp[@"mail"]},
                                @{@"label":@"地址",@"text":tmp[@"address"]},
                                @{@"label":@"facebook",@"text":tmp[@"facebook"]},
                                @{@"label":@"line",@"text":tmp[@"line"]},
                                @{@"label":@"公司名稱",@"text":tmp[@"companyname"]},
                                @{@"label":@"網址",@"text":tmp[@"web"]}];
            
            NSLog(@"number : %@", tmp[@"number"]);
            NSLog(@"name : %@", tmp[@"name"]);
            NSLog(@"%@",arrayOfCellData);
            
        }
        
        [self.tableView reloadData];
        
    }];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // You code here to update the view.
    [self startGetMyData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return arrayOfCellData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    cell.labelText.text = arrayOfCellData[indexPath.row][@"label"];
    if (arrayOfCellData[indexPath.row][@"text"]) {
        NSString *test = arrayOfCellData[indexPath.row][@"text"];
        NSLog(@"%@",test);
        cell.inputText.text = test;
        [inputArray addObject:cell.inputText];
    }


    

    // Configure the cell...
    return cell;
}

- (IBAction)saveMyData:(id)sender {
    NSMutableArray *inputString = [NSMutableArray new];
    for (UITextField *textField in inputArray) {
        NSLog(@"輸入字：%@",textField.text);
        [inputString addObject:textField.text];
    }
    NSDictionary *parameters = @{@"id":dataManager.userId,
                                 @"name":inputString[0],
                                 @"phone":inputString[1],
                                 @"loacalphone":inputString[2],
                                 @"mail":inputString[3],
                                 @"address":inputString[4],
                                 @"facebook":inputString[5],
                                 @"line":inputString[6],
                                 @"companyname":inputString[7],
                                 @"webURL":inputString[8]};
    //NSLog(@"%@",parameters);

    [server doPostJobWithURLString:UPDATE_USERDATA_URL parameters:parameters data:nil completion:^(NSError *error, id result) {
        NSString *log;
        if (error) {
            log = @"資料保存失敗";
        }else{
            log = @"資料保存成功";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:log message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:cancelAction];
        //把Alert對話框顯示出來
        [self presentViewController:alertController animated:YES completion:nil];
    }];

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
