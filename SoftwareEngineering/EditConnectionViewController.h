//
//  EditConnectionViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/18/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditConnectionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *dbUsernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *dbPasswordTextField;
@property (weak, nonatomic) IBOutlet UINavigationBar *editConnectionNavigation;
@property (weak, nonatomic) IBOutlet UITextField *dbConnectionStringTextField;
- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;

@end
