//
//  NotNullCreationViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/25/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "NotNullCreationViewController.h"
#import "EDJTableSubmissionViewController.h"
@interface NotNullCreationViewController ()

@end

@implementation NotNullCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    self.title = [NSString stringWithFormat:@"%@: Not Null", self.actionColumn];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"goToSubmit"]) {
        NSString *keyName = self.constrainNameTextField.text;
        NSString *actionColumn = self.actionColumn;
        
        EDJTableSubmissionViewController *destin = (EDJTableSubmissionViewController *)segue.destinationViewController;
        [destin performAction:^(UIViewController *current){
           [[EDJTableServices sharedInstance] addNotNullConstraintWithName:keyName table:[self.table getName] columnName:actionColumn withCompletion:^(BOOL complete){
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
