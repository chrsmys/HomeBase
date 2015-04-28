//
//  CheckCreationViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/25/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "CheckCreationViewController.h"
#import "EDJTableSubmissionViewController.h"
@interface CheckCreationViewController ()

@end

@implementation CheckCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=[NSString stringWithFormat:@"%@: Check Constraint", self.actionColumn];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    self.conditionTextField.text = self.actionColumn;
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(nextButtonPressed)];
    self.navigationItem.rightBarButtonItem = nextButton;
    
}

-(void)nextButtonPressed{
    [self performSegueWithIdentifier:@"goToSubmit" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"goToSubmit"]) {
        NSString *keyName = self.constrainNameTextField.text;
        NSString *condition = self.conditionTextField.text;

        EDJTableSubmissionViewController *destin = (EDJTableSubmissionViewController *)segue.destinationViewController;
        [destin performAction:^(UIViewController *current){
            [[EDJTableServices sharedInstance] addCheckConstraintWithName:keyName table:[self.table getName] condition:condition withCompletion:^(BOOL complete){
                [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                    [current dismissViewControllerAnimated:true completion:nil];
                }];
            } withError:^(NSString *error){
                [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:[NSString stringWithFormat:@"error %@", error] delegate:nil cancelButtonTitle:@"Done" otherButtonTitles: nil];
                    [alert show];
                    [current.navigationController popViewControllerAnimated:YES];
                }];
            }];
        }];
    }
}

@end