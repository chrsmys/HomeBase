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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.FKTextView.text = self.fkText;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)doneButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
