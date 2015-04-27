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
#import "EDJTableServices.h"
@interface EditConnectionViewController ()

@end

@implementation EditConnectionViewController
@synthesize dbUsernameTextField;
@synthesize dbPasswordTextField;
@synthesize dbConnectionStringTextField;
@synthesize editConnectionNavigation;
- (void)viewDidLoad
{
    [super viewDidLoad];
    dbUsernameTextField.text = [[EDJUser sharedInstance] getDBUsername];
    dbConnectionStringTextField.text = [[EDJUser sharedInstance] getConnectionString];
    [dbUsernameTextField becomeFirstResponder];
    editConnectionNavigation.tintColor = [UIColor colorWithRed:0.125 green:0.42 blue:0.608 alpha:1];
    self.view.backgroundColor = [UIColor colorWithRed:0.871 green:0.933 blue:0.988 alpha:1];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonPressed:(id)sender
{
    /*[[EDJAccountManager sharedInstance] changeConnectionForCurrentUser:dbUsernameTextField.text password:dbPasswordTextField.text connectionString:dbConnectionStringTextField.text];
    [[EDJAccountManager sharedInstance] addSchemaToDefaults:@{@"Username" : dbUsernameTextField.text,
                                                              @"Password" : dbPasswordTextField.text,
                                                              @"ConnectionString" : dbConnectionStringTextField.text
                                                              }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
    NSLog(@"saved %@", [[EDJUser sharedInstance] getDBPassword]);
    [self dismissViewControllerAnimated:YES completion:nil];*/
    
    
    
    [self.activityIndicator startAnimating];
    self.dbUsernameTextField.hidden=true;
    self.dbPasswordTextField.hidden=true;
    self.dbConnectionStringTextField.hidden=true;
    
    [[EDJTableServices sharedInstance] loginValidator:self.dbUsernameTextField.text password:self.dbPasswordTextField.text connectionString:self.dbConnectionStringTextField.text withCompletion:^(BOOL completion){
        [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
            [self.activityIndicator stopAnimating];
            [[EDJAccountManager sharedInstance] addSchemaToDefaults:@{
                                                                      @"Username" : self.dbUsernameTextField.text,
                                                                      @"Password" : self.dbPasswordTextField.text,
                                                                      @"ConnectionString" : self.dbConnectionStringTextField.text
                                                                      }];
            
            [[EDJAccountManager sharedInstance] changeConnectionForCurrentUser:self.dbUsernameTextField.text password:self.dbPasswordTextField.text connectionString:self.dbConnectionStringTextField.text];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }];
        
    } withError:^(NSString *error){
        self.dbUsernameTextField.hidden=false;
        self.dbPasswordTextField.hidden=false;
        self.dbConnectionStringTextField.hidden=false;
        [self.activityIndicator stopAnimating];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Logging In" message:@"Please make sure you have your username, password, and connection string are correct" delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles: nil];
        [alert show];
    }];
    
    
    
}
@end
