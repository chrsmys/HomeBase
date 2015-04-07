//
//  EditTableNameViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/6/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "EditTableNameViewController.h"
#import "EDJTableSubmissionViewController.h"
#import "EDJTableServices.h"
@interface EditTableNameViewController ()

@end

@implementation EditTableNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tableNameTextField becomeFirstResponder];
    [self.tableNameTextField setText:self.tableName];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)doneButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"goToSubmit" sender:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"goToSubmit"]) {
        if ([segue.destinationViewController isKindOfClass:[EDJTableSubmissionViewController class]]) {
            EDJTableSubmissionViewController *destination = (EDJTableSubmissionViewController *)segue.destinationViewController;
            [destination performAction:^(UIViewController *controller){
                [[EDJTableServices sharedInstance] changeTableName:self.tableName newName:self.tableNameTextField.text withCompletion:^(BOOL complete){
                    
                    [controller dismissViewControllerAnimated:true completion:nil];
                    
                }withError:^(NSString *error){
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:@"error" delegate:nil cancelButtonTitle:@"Done" otherButtonTitles: nil];
                    [alert show];
                }];
                
                
            }];
        }
    }
}


@end
