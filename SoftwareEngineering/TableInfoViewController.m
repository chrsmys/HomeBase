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
#import "ConstraintDataSource.h"
@interface TableInfoViewController ()
@property (nonatomic) TriggerInfoDataSource* triggerDataSource;
@property (nonatomic) ConstraintDataSource* constraintDataSource;

@end

@implementation TableInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.foreignKeyInfoTextView.text = [self.table getForeignKeyText];

    _triggerDataSource = [[TriggerInfoDataSource alloc] init];
    _constraintDataSource = [[ConstraintDataSource alloc] init];

    self.triggerDataSource.table = self.table;
    _constraintDataSource.table = self.table;

    self.triggerInfoTableView.dataSource = _triggerDataSource;
    self.triggerInfoTableView.delegate = _triggerDataSource;
    self.constraintTableView.dataSource = _constraintDataSource;
    self.constraintTableView.delegate = _constraintDataSource;

    _triggerDataSource.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.foreignKeyInfoTextView.text = [self.table getForeignKeyText];
}

- (void)selectedTrigger:(EDJTrigger*)trigger
{
    selectedTrigger = trigger;
    [self performSegueWithIdentifier:@"ShowTriggerDetail" sender:trigger];
    NSLog(@"%@", selectedTrigger.body);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation
- (void)setTable:(EDJTable*)table
{
    _table = table;
    self.foreignKeyInfoTextView.text = [self.table getForeignKeyText];
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DisplayTableColumnInfo"]) {
        EDJColumnTableViewController* edj = (EDJColumnTableViewController*)segue.destinationViewController;
        edj.editableTable = true;
        edj.table = self.table;
    }
    else if ([segue.identifier isEqualToString:@"ShowTriggerDetail"]) {
        UIViewController* destinationController = segue.destinationViewController;

        if ([destinationController isKindOfClass:[UINavigationController class]]) {
            destinationController = segue.destinationViewController;
        }
        destinationController = [[(UINavigationController*)destinationController viewControllers] firstObject];
        if ([destinationController isKindOfClass:[TriggerDetailViewController class]]) {
            TriggerDetailViewController* edj = (TriggerDetailViewController*)destinationController;
            edj.trigger = (EDJTrigger*)sender;
        }
    }
}

@end
