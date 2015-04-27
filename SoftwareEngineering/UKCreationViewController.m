//
//  UKCreationViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/25/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "UKCreationViewController.h"
#import "EDJKeySelectionDataSource.h"
#import "EDJTableSubmissionViewController.h"
#import "EDJTableServices.h"
@interface UKCreationViewController ()
@property (nonatomic,retain) EDJKeySelectionDataSource *keySelection;
@end

@implementation UKCreationViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}
-(void)viewDidAppear:(BOOL)animated{
    self.keySelection = [[EDJKeySelectionDataSource alloc] initWithTable:self.table withColumnsInKey:@[self.actionColumn]];
    self.ukKeyTableView.delegate=self.keySelection;
    self.ukKeyTableView.dataSource=self.keySelection;
    self.ukKeyTableView.editing=true;
    [self.ukKeyTableView reloadData];
    
    
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
        NSString *keyName = self.constraintTextField.text;
                    EDJTableSubmissionViewController *destin = (EDJTableSubmissionViewController *)segue.destinationViewController;
        [destin performAction:^(UIViewController *current){
            [[EDJTableServices sharedInstance] addUniqueKeyWithName:keyName table:[self.table getName] columnsInKey:self.keySelection.inKey withCompletion:^(BOOL complete){
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                        [current dismissViewControllerAnimated:true completion:nil];
                    }];
                } withError:^(NSString *error){
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:[NSString stringWithFormat:@"error %@", error] delegate:nil cancelButtonTitle:@"Done" otherButtonTitles: nil];
                        [alert show];
                        [current.navigationController popViewControllerAnimated:YES];
                    }];
                }
             ];
        }];
    }
}


@end
