//
//  EDJListTableTableViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/17/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "EDJListTableTableViewController.h"
#import "EDJTableServices.h"
#import "EDJTable.h"
#import "EDJColumnTableViewController.h"
@interface EDJListTableTableViewController ()

@end

@implementation EDJListTableTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[EDJTableServices sharedInstance] tables] count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [(EDJTable*)[[[EDJTableServices sharedInstance] tables] objectAtIndex:indexPath.row] getName];

    return cell;
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([identifier isEqualToString:@"goToColumnList"]) {
        if(!self.shouldGoToColumns){
            EDJTable *table =[[[EDJTableServices sharedInstance] tables] objectAtIndex:[self.tableView indexPathForSelectedRow].row];
            [self.delegate didSelectTableWithTableName:[table getName]];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
        return self.shouldGoToColumns;
    }
    return true;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"goToColumnList"]) {
        if ([segue.destinationViewController isKindOfClass:[EDJColumnTableViewController class]]) {
            EDJColumnTableViewController* col = segue.destinationViewController;
            col.table = [[[EDJTableServices sharedInstance] tables] objectAtIndex:[self.tableView indexPathForSelectedRow].row];
            col.delegate = self.delegate;
        }
    }
}

@end
