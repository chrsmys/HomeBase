//
//  LoginViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/11/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import "LoginViewController.h"
#import "EDJWebImageView.h"
#import "NSString+MD5.h"
#import "EDJAccountManager.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize Company_Logo;
@synthesize usernameTextField;
@synthesize passwordTextField;
@synthesize loginButton;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor colorWithRed:0.125 green:0.42 blue:0.608 alpha:1];
    [self createGUI];
    loginButton.tintColor=[UIColor colorWithRed:0.871 green:0.933 blue:0.988 alpha:1];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
-(void)createGUI{
    /*
     *******************************************
         Creating the Image View
     *******************************************
     
     */
    
    /*
        Check if there is a cached logo
     
     */
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"CompanyImage"]!=nil){
        Company_Logo.image=[UIImage imageNamed:@"image00.png"];
        Company_Logo.image=[UIImage imageWithData:(NSData *)([[NSUserDefaults standardUserDefaults] objectForKey:@"CompanyImage"])];
    }
    
    
    //Loading Image from URL
    [Company_Logo setImageWithURL:[NSURL URLWithString:@"https://php.radford.edu/~tfreeman3/Homebase/Images/image00.png"] chacheImageToDefaultsKey:@"CompanyImage"];
    


}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (IBAction)LoginButtonPressed:(id)sender {
    if([[EDJAccountManager sharedInstance] createUser:@"Dave" pass:@"dave" dbUsername:@"cmays2" dbPassword:@"f5288e4e6b" connectionString:@"//137.45.192.130/itec2.radford.edu"]){
    }
    if([[EDJAccountManager sharedInstance] loginUserWithUsername:usernameTextField.text password:passwordTextField.text]){
        [self performSegueWithIdentifier:@"loggedIn" sender:self];
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Failed Login" message:@"The Username/Password was incorrect" delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles: nil];
        [alert show];
    }
}
@end
