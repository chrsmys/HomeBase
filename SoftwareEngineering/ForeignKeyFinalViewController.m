//
//  ForeignKeyFinalViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/17/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "ForeignKeyFinalViewController.h"
#import "EDJTableCreationRequest.h"
#import "EDJFKConstraint.h"
#import "EDJTableSubmissionViewController.h"
#import "EDJListTableTableViewController.h"

@interface ForeignKeyFinalViewController ()
@property (nonatomic) NSMutableArray* fkViews;
@end

@implementation ForeignKeyFinalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.fkViews = [[NSMutableArray alloc] init];
    [self updateUI];

    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
}

- (void)updateUI
{
    NSArray* fk = self.tableRequest.listOfPossibleFKNames;
    for (int i = 0; i < fk.count; i++) {
        EDJFKConstraint* constraint = [EDJFKConstraint getView];
        constraint.delegate = self;
        constraint.fkColumnName.text = [fk objectAtIndex:i];
        constraint.frame = CGRectMake(0, i * 300, self.fkConstraintsScrollView.frame.size.width, 300);
        [self.fkViews addObject:constraint];
        [self.fkConstraintsScrollView addSubview:constraint];
    }
    [self.fkConstraintsScrollView setContentSize:CGSizeMake(self.fkConstraintsScrollView.frame.size.width, self.tableRequest.listOfPossibleFKNames.count * 300 + 70)];
    UIButton* doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [doneButton setFrame:CGRectMake(self.fkConstraintsScrollView.frame.size.width - 300, (fk.count * 300) + 10, 100, 40)];

    [doneButton.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:16]];
    [doneButton setTitle:@"Next \uf105" forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
    [self.fkConstraintsScrollView addSubview:doneButton];
}

- (void)didSelectTableViewWithConstraint:(EDJFKConstraint*)constraint
{
    self.lastTouched = constraint;
    [self performSegueWithIdentifier:@"displayTables" sender:self];
}

- (void)goNext
{
    [self performSegueWithIdentifier:@"goToSubmissionView" sender:self];
}

- (void)setTableRequest:(EDJTableCreationRequest*)tableRequest
{
    _tableRequest = tableRequest;
    [self updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didSelectTableWithTableName:(NSString*)tableName withColumnName:(NSString*)columnName
{
    [self.lastTouched.selectTableButton setTitle:[NSString stringWithFormat:@"Referenceing Table:%@ Referencing Column:%@", tableName, columnName] forState:UIControlStateNormal];
    [self.lastTouched setRefrencingColumnName:columnName];
    [self.lastTouched setRefrencingTableName:tableName];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"goToSubmissionView"]) {
        if ([segue.destinationViewController isKindOfClass:[EDJTableSubmissionViewController class]]) {
            EDJTableSubmissionViewController* submission = segue.destinationViewController;
            [[self.tableRequest foriegnKeys] removeAllObjects];
            for (int i = 0; i < [self.fkViews count]; i++) {
                EDJFKConstraint* constraint = [self.fkViews objectAtIndex:i];
                [self.tableRequest addForiegnKeyWithConstraintName:constraint.constraintNameTextField.text tableColumn:constraint.fkColumnName.text refTable:constraint.refrencingTableName refCol:constraint.refrencingColumnName deferable:constraint.deferableSwitch.isOn];
            }
            submission.tableRequest = self.tableRequest;
        }
    }

    if ([segue.identifier isEqualToString:@"displayTables"]) {
        UIViewController* currentDestination = segue.destinationViewController;
        if ([currentDestination isKindOfClass:[UINavigationController class]]) {
            currentDestination = [[((UINavigationController*)currentDestination)viewControllers] firstObject];
        }
        if ([currentDestination isKindOfClass:
                                    [EDJListTableTableViewController class]]) {
            EDJListTableTableViewController* dest = (EDJListTableTableViewController*)currentDestination;
            dest.delegate = self;
        }
    }
}

@end
