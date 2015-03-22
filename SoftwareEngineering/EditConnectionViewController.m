//
//  EditConnectionViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/18/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import "EditConnectionViewController.h"
#import "EDJUser.h"
#import "EDJAccountManager.h"
@interface EditConnectionViewController ()

@end

@implementation EditConnectionViewController
@synthesize dbUsernameTextField;
@synthesize dbPasswordTextField;
@synthesize dbConnectionStringTextField;
@synthesize editConnectionNavigation;
- (void)viewDidLoad {
    [super viewDidLoad];
    dbUsernameTextField.text=[[EDJUser sharedInstance] getDBUsername];
    dbConnectionStringTextField.text=[[EDJUser sharedInstance] getConnectionString];
    [dbUsernameTextField becomeFirstResponder];
    editConnectionNavigation.tintColor=[UIColor colorWithRed:0.125 green:0.42 blue:0.608 alpha:1];
    self.view.backgroundColor=[UIColor colorWithRed:0.871 green:0.933 blue:0.988 alpha:1];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonPressed:(id)sender {
    [[EDJAccountManager sharedInstance] changeConnectionForCurrentUser:dbUsernameTextField.text password:dbPasswordTextField.text connectionString:dbConnectionStringTextField.text];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
    NSLog(@"saved %@", [[EDJUser sharedInstance] getDBPassword]);
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
