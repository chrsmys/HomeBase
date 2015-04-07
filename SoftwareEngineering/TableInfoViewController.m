//
//  TableInfoViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/28/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "TableInfoViewController.h"
#import "EDJColumnTableViewController.h"
#import "TriggerInfoDataSource.h"
#import "TriggerDetailViewController.h"
@interface TableInfoViewController ()
@property (nonatomic) TriggerInfoDataSource *triggerDataSource;
@end

@implementation TableInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.foreignKeyInfoTextView.text = [self.table getForeignKeyText];
    _triggerDataSource = [[TriggerInfoDataSource alloc] init];
    self.triggerDataSource.table = self.table;
    self.triggerInfoTableView.dataSource=_triggerDataSource;
    self.triggerInfoTableView.delegate=_triggerDataSource;
    _triggerDataSource.delegate=self;
}

-(void)viewWillAppear:(BOOL)animated{
    self.foreignKeyInfoTextView.text = [self.table getForeignKeyText];
}

-(void)selectedTrigger:(EDJTrigger *)trigger{
    selectedTrigger=trigger;
    NSLog(@"selected trigger");
    [self performSegueWithIdentifier:@"ShowTriggerDetail" sender:trigger];
    NSLog(@"%@", selectedTrigger.body);
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
        edj.editableTable=true;
        edj.table=self.table;
    }else if ([segue.identifier isEqualToString:@"ShowTriggerDetail"]){
        TriggerDetailViewController *edj = (TriggerDetailViewController *)segue.destinationViewController;
        edj.trigger=(EDJTrigger *)sender;
        NSLog(@"segue");
    }
}


@end
