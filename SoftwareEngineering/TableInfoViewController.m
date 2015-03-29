//
//  TableInfoViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/28/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "TableInfoViewController.h"
#import "EDJColumnTableViewController.h"
@interface TableInfoViewController ()

@end

@implementation TableInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.foreignKeyInfoTextView.text = [self.table getForeignKeyText];
}

-(void)viewWillAppear:(BOOL)animated{
    self.foreignKeyInfoTextView.text = [self.table getForeignKeyText];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation
-(void)setTable:(EDJTable *)table{
    _table=table;
    self.foreignKeyInfoTextView.text = [self.table getForeignKeyText];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DisplayTableColumnInfo"]) {
        EDJColumnTableViewController *edj = (EDJColumnTableViewController *)segue.destinationViewController;
        edj.table=self.table;
    }
}


@end
