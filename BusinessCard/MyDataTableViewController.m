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

@interface MyDataTableViewController (){
    NSArray *arrayOfCellData;
    ServerCommunicator *server;
}

@end


@implementation MyDataTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    arrayOfCellData = @[@{@"label":@"姓名",@"text":@""},
                        @{@"label":@"電話",@"text":@""},
                        @{@"label":@"市話",@"text":@""},
                        @{@"label":@"E-mail",@"text":@""},
                        @{@"label":@"地址",@"text":@""},
                        @{@"label":@"facebook",@"text":@""},
                        @{@"label":@"line",@"text":@""},
                        @{@"label":@"公司名稱",@"text":@""},
                        @{@"label":@"網址",@"text":@""}];
    server = [ServerCommunicator sharedInstance];
    [server doPostJobWithURLString:GET_USERDATA_URL parameters:@{@"id":@"1"} data:nil completion:^(NSError *error, id result) {
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
                                @{@"label":@"電話",@"text":@""},
                                @{@"label":@"市話",@"text":@""},
                                @{@"label":@"E-mail",@"text":@""},
                                @{@"label":@"地址",@"text":@""},
                                @{@"label":@"facebook",@"text":@""},
                                @{@"label":@"line",@"text":@""},
                                @{@"label":@"公司名稱",@"text":@""},
                                @{@"label":@"網址",@"text":@""}];
            NSLog(@"number : %@", tmp[@"number"]);
            NSLog(@"name : %@", tmp[@"name"]);
        }
        
        [self.tableView reloadData];

    }];

    

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    TableViewCell1 *cell = (TableViewCell1*)[tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    cell.labelText.text = arrayOfCellData[indexPath.row][@"label"];
    cell.inputText.text = arrayOfCellData[indexPath.row][@"text"];

    // Configure the cell...
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
