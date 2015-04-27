//
//  EDJOnboardingLoginViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/27/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "EDJOnboardingLoginViewController.h"
#import "EDJAccountManager.h"
#import "EDJTableServices.h"
@interface EDJOnboardingLoginViewController ()

@end

@implementation EDJOnboardingLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    self.connectionStringTextField.text=@"//137.45.192.130/itec2.radford.edu";
    [UIView animateWithDuration:0.5 animations:^(void){
        self.loginView.alpha=1.0;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPressed:(id)sender {
    [self.activityIndicator startAnimating];
    self.loginView.hidden=true;
    [[EDJTableServices sharedInstance] loginValidator:self.usernameTextField.text password:self.passwordTextField.text connectionString:self.connectionStringTextField.text withCompletion:^(BOOL completion){
        [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
            [self.activityIndicator stopAnimating];
            [[EDJAccountManager sharedInstance] addSchemaToDefaults:@{
                                    @"Username" : self.usernameTextField.text,
                                    @"Password" : self.passwordTextField.text,
                                    @"ConnectionString" : self.connectionStringTextField.text
                                                                      }];
            
            [[EDJAccountManager sharedInstance] changeConnectionForCurrentUser:self.usernameTextField.text password:self.passwordTextField.text connectionString:self.connectionStringTextField.text];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        
        }];
    
        } withError:^(NSString *error){
            [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
            self.loginView.hidden=false;
            [self.activityIndicator stopAnimating];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Logging In" message:@"Please make sure you have your username, password, and connection string are correct" delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles: nil];
            [alert show];
            }];
        }];
   
    
}
@end
