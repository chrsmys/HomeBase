//
//  LoginViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/11/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDJWebImageView.h"
@interface LoginViewController : UIViewController {
    EDJWebImageView* imagev;
}
@property (weak, nonatomic) IBOutlet UIButton* loginButton;
@property (weak, nonatomic) IBOutlet EDJWebImageView* Company_Logo;
@property (weak, nonatomic) IBOutlet UITextField* usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField* passwordTextField;
- (IBAction)LoginButtonPressed:(id)sender;

@end
