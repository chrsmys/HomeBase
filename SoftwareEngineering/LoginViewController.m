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
    // Do any additional setup after loading the view.
   
   self.view.backgroundColor=[UIColor colorWithRed:0.125 green:0.42 blue:0.608 alpha:1];
    [self createGUI];
     NSLog(@"%d",[[[[NSUserDefaults standardUserDefaults] objectForKey:@"Users"] allKeys] count]);
    loginButton.tintColor=[UIColor colorWithRed:0.871 green:0.933 blue:0.988 alpha:1];
    //[usernameTextField becomeFirstResponder];

    
    
}
/*- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationPortrait;
}*/
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


-(void)testingLogin{
    NSLog(@"Password: %@", [@"Dave" MD5String]);
    
   
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

- (IBAction)LoginButtonPressed:(id)sender {
    if([[EDJAccountManager sharedInstance] createUser:@"Dave" pass:@"dave" dbUsername:@"cmays2" dbPassword:@"f5288e4e6b" connectionString:@"//137.45.192.130/itec2.radford.edu"]){
        NSLog(@"Created account dave");
    }
    if([[EDJAccountManager sharedInstance] loginUserWithUsername:usernameTextField.text password:passwordTextField.text]){
       // UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Logged in" message:@"You Logged in" delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles: nil];
        //[alert show];
        [self performSegueWithIdentifier:@"loggedIn" sender:self];
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Failed Login" message:@"The Username/Password was incorrect" delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles: nil];
        [alert show];
    }
}
@end
