//
//  FKListViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/17/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "FKListViewController.h"

@interface FKListViewController ()

@end

@implementation FKListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.FKTextView.text=self.fkText;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)doneButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
