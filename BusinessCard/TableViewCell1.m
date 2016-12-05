//
//  TableViewCell1.m
//  BusinessCard
//
//  Created by Snos on 2016/12/2.
//  Copyright © 2016年 Snow. All rights reserved.
//

#import "TableViewCell1.h"

@implementation TableViewCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_inputText addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)textFieldDone:(UITextField*)textField
{
    [textField resignFirstResponder];
}



@end
