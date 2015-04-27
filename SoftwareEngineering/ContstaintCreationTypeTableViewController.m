//
//  ContstaintCreationTypeTableViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/25/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "ContstaintCreationTypeTableViewController.h"
#import "UKCreationViewController.h"
#import "CheckCreationViewController.h"
#import "NotNullCreationViewController.h"
#import "FKCreationViewController.h"
#import "PrimaryKeyCreationViewController.h"
@interface ContstaintCreationTypeTableViewController ()

@end

@implementation ContstaintCreationTypeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"GoToUnique"]) {
        UKCreationViewController *dest = (UKCreationViewController *)segue.destinationViewController;
        dest.table=self.table;
        dest.actionColumn=self.actionColumn;
        
    }else if ([segue.identifier isEqualToString:@"GoToCheck"]) {
        CheckCreationViewController *dest = (CheckCreationViewController *)segue.destinationViewController;
        dest.table=self.table;
        dest.actionColumn=self.actionColumn;
        
    }else if ([segue.identifier isEqualToString:@"GoToNotNull"]) {
        NotNullCreationViewController  *dest = (NotNullCreationViewController *)segue.destinationViewController;
        dest.table=self.table;
        dest.actionColumn=self.actionColumn;
    }else if ([segue.identifier isEqualToString:@"GoToForeign"]) {
        FKCreationViewController  *dest = (FKCreationViewController *)segue.destinationViewController;
        dest.table=self.table;
        dest.actionColumn=self.actionColumn;
    }
    else if ([segue.identifier isEqualToString:@"GoToPrimary"]) {
        PrimaryKeyCreationViewController  *dest = (PrimaryKeyCreationViewController *)segue.destinationViewController;
        dest.table=self.table;
        dest.actionColumn=self.actionColumn;
    }
    
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
