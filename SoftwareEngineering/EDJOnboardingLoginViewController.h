//
//  EDJOnboardingLoginViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/27/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDJOnboardingLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *connectionStringTextField;
- (IBAction)loginButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *usernameTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passwordTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *connectionStringTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLoginConstraint;

@end
