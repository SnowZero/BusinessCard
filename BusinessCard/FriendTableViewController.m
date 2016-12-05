//
//  FriendTableViewController.m
//  BusinessCard
//
//  Created by Snos on 2016/12/4.
//  Copyright © 2016年 Snow. All rights reserved.
//

#import "FriendTableViewController.h"
#import "ServerCommunicator.h"
#import "FriendTableViewCell.h"

@interface FriendTableViewController (){
    ServerCommunicator *server;
    NSMutableArray *arrayOfCellData;
}

@end

@implementation FriendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    arrayOfCellData = [NSMutableArray new];
    
    server = [ServerCommunicator sharedInstance];
    [server doPostJobWithURLString:GET_USERDATA_URL parameters:@{@"id":_friendID} data:nil completion:^(NSError *error, id result) {
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
    FriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell" forIndexPath:indexPath];
    cell.textField.text = arrayOfCellData[indexPath.row][@"label"];
    if (arrayOfCellData[indexPath.row][@"text"]) {
        NSString *test = arrayOfCellData[indexPath.row][@"text"];
        NSLog(@"%@",test);
        cell.textField2.text = test;
    }
    return cell;
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
