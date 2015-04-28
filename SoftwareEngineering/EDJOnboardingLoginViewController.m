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
     self.view.backgroundColor=[UIColor colorWithRed:0.125 green:0.42 blue:0.608 alpha:1];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    self.bottomLoginConstraint.constant-=50;
}
-(void)viewDidAppear:(BOOL)animated{
    self.connectionStringTextField.text=@"//137.45.192.130/itec2.radford.edu";
    self.usernameTopConstraint.constant+=25;
    self.passwordTopConstraint.constant+=25;
    self.connectionStringTopConstraint.constant+=25;

    [UIView animateWithDuration:0.5 animations:^(void){
        self.loginView.alpha=1.0;
        [UIView animateWithDuration:0.5 animations:^(void){
            self.usernameTopConstraint.constant-=25;
            self.usernameTextField.alpha=1;
            [self.view layoutIfNeeded];
        }completion:^(BOOL finished){
            [UIView animateWithDuration:0.5 animations:^(void){
                self.passwordTopConstraint.constant-=25;
                self.passwordTextField.alpha=1;
                [self.view layoutIfNeeded];
            }completion:^(BOOL finished){
                [UIView animateWithDuration:0.5 animations:^(void){
                    self.connectionStringTopConstraint.constant-=25;
                    self.connectionStringTextField.alpha=1;
                    [self.view layoutIfNeeded];
                }completion:^(BOOL finished){
                    [UIView animateWithDuration:0.5 animations:^(void){
                        self.bottomLoginConstraint.constant+=50;
                        [self.view layoutIfNeeded];
                    }completion:^(BOOL finished){
                        
                    }];
                }];
            }];
        }];
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
