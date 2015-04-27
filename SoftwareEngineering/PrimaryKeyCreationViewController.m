//
//  PrimaryKeyCreationViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/26/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "PrimaryKeyCreationViewController.h"
#import "EDJKeySelectionDataSource.h"
#import "EDJTableServices.h"
#import "EDJTableSubmissionViewController.h"
@interface PrimaryKeyCreationViewController ()
@property(nonatomic) EDJKeySelectionDataSource *dataSource;
@end

@implementation PrimaryKeyCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    self.dataSource = [[EDJKeySelectionDataSource alloc] initWithTable:self.table withColumnsInKey:@[self.actionColumn]];
    self.keySelectionTableView.dataSource = self.dataSource;
    self.keySelectionTableView.delegate = self.dataSource;
    [self.keySelectionTableView reloadData];
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(nextButtonPressed)];
    self.navigationItem.rightBarButtonItem = nextButton;
    
    self.title = [NSString stringWithFormat:@"%@: FK Constraint", [self.table getName]];
}

-(void)nextButtonPressed{
    [self performSegueWithIdentifier:@"moveToSubmission" sender:self];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"moveToSubmission"]) {
        NSString *tableName = [self.table getName];
        NSString *consName = self.constraintNameTextField.text;
        
        EDJTableSubmissionViewController *submission = segue.destinationViewController;
        [submission performAction:^(UIViewController *current){
            [[EDJTableServices sharedInstance] addPKConstraintWithName:consName table:tableName cols:self.dataSource.inKey withCompletion:^(BOOL complete){
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
