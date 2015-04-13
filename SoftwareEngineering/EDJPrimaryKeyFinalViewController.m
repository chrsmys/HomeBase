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
@interface EDJPrimaryKeyFinalViewController ()

@end

@implementation EDJPrimaryKeyFinalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(nextButtonPressed)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (void)nextButtonPressed
{
    [self performSegueWithIdentifier:@"showFKConstraints" sender:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.primaryKeyListView.text = [self primaryKeyList];
    NSArray* tableRequest = [self.tableRequest listOfPrimaryKeys];
    if ([tableRequest count] == 1) {
        self.constraintNameTextField.text = [NSString stringWithFormat:@"%@_%@_PK", [self.tableRequest.tableName uppercaseString], [[self getShortestPrimaryKey] uppercaseString]];
    }
    else if ([tableRequest count] > 1) {
        self.constraintNameTextField.text = [NSString stringWithFormat:@"%@_COMPOSITE_PK", [self.tableRequest.tableName uppercaseString]];
    }
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
    if ([segue.identifier isEqualToString:@"showFKConstraints"]) {
        if ([segue.destinationViewController isKindOfClass:[ForeignKeyFinalViewController class]]) {
            ForeignKeyFinalViewController* final = segue.destinationViewController;
            [self.tableRequest addPrimaryKeyWithConstraintName:self.constraintNameTextField.text withColumns:self.tableRequest.listOfPrimaryKeys];
            final.tableRequest = self.tableRequest;
        }
    }
}

@end
