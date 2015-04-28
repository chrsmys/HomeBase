//
//  EDJPrimaryKeyFinalViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/17/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "EDJPrimaryKeyFinalViewController.h"
#import "EDJTableCreationRequest.h"
#import "ForeignKeyFinalViewController.h"
#import "EDJKeySelectionDataSource.h"
#import "EDJTableSubmissionViewController.h"
@interface EDJPrimaryKeyFinalViewController ()
@property (nonatomic) EDJKeySelectionDataSource* dataSource;
@end

@implementation EDJPrimaryKeyFinalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(nextButtonPressed)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (void)nextButtonPressed
{
    [self performSegueWithIdentifier:@"goToSubmissionView" sender:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.primaryKeyListView.text = [self primaryKeyList];
    self.dataSource = [[EDJKeySelectionDataSource alloc] initWithArray:[self.tableRequest getColumnList] withColumnsInKey:nil];
    self.primaryKeyTableView.dataSource = self.dataSource;
    self.primaryKeyTableView.delegate = self.dataSource;
    [self.primaryKeyTableView reloadData];
    /*NSArray* tableRequest = [self.tableRequest listOfPrimaryKeys];
    if ([tableRequest count] == 1) {
        self.constraintNameTextField.text = [NSString stringWithFormat:@"%@_%@_PK", [self.tableRequest.tableName uppercaseString], [[self getShortestPrimaryKey] uppercaseString]];
    }
    else if ([tableRequest count] > 1) {
        self.constraintNameTextField.text = [NSString stringWithFormat:@"%@_COMPOSITE_PK", [self.tableRequest.tableName uppercaseString]];
    }*/
}
- (NSString*)primaryKeyList
{
    NSArray* tableRequest = [self.tableRequest listOfPrimaryKeys];
    NSString* pkList = @"";
    for (int i = 0; i < [tableRequest count]; i++) {

        pkList = [NSString stringWithFormat:@"%@%@\n", pkList, [tableRequest objectAtIndex:i]];
    }
    return pkList;
}
- (NSString*)getShortestPrimaryKey
{
    NSArray* tableRequest = [self.tableRequest listOfPrimaryKeys];
    if (!([tableRequest count] > 0)) {
        return @"";
    }
    NSString* shortestPK = [tableRequest objectAtIndex:0];
    for (NSString* PK in tableRequest) {
        shortestPK = PK.length < shortestPK.length ? PK : shortestPK;
    }
    return shortestPK;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"goToSubmissionView"]) {
        if(self.constraintNameTextField.text!=nil && ![self.constraintNameTextField.text isEqualToString:@""] && [self.dataSource.inKey count]>0){
            [self.tableRequest addPrimaryKeyWithConstraintName:self.constraintNameTextField.text withColumns:self.dataSource.inKey];
        }
        EDJTableSubmissionViewController* submission = segue.destinationViewController;
        submission.tableRequest = self.tableRequest;
    }
}

@end
