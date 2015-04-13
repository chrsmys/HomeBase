//
//  TriggerDetailViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/1/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "TriggerDetailViewController.h"
#import "EDJTrigger.h"
@interface TriggerDetailViewController ()

@end

@implementation TriggerDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated
{
    self.triggerCodeDisplay.text = [_trigger body];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTrigger:(EDJTrigger*)trigger
{
    self.triggerCodeDisplay.text = [trigger body];
    _trigger = trigger;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doneButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
