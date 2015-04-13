//
//  ConstraintDataSource.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/7/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "ConstraintDataSource.h"
#import "ConstraintTableViewCell.h"
#import "EDJTableServices.h"
@implementation ConstraintDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.table constraints] count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    EDJConstraint* constraint = [[self.table constraints] objectAtIndex:indexPath.row];
    ConstraintTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ConstraintCell" forIndexPath:indexPath];
    cell.constraintNameLabel.text = [constraint constraintName];
    cell.tableColumnLabel.text = [NSString stringWithFormat:@"%@ -> %@", constraint.tableName, constraint.columnName];
    cell.enabled = constraint.enabled;
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
}

- (BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath
{
    return true;
}
- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EDJConstraint* constraint = [[self.table constraints] objectAtIndex:indexPath.row];

        [[EDJTableServices sharedInstance] removeConstraint:[constraint constraintName] InTable:[constraint tableName] withCompletion:^(BOOL finished) {
            [[self.table constraints] removeObjectAtIndex:indexPath.row];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableView beginUpdates];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                [tableView endUpdates];
            });

        } withError:^(NSString* error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:error delegate:nil cancelButtonTitle:@"Done" otherButtonTitles: nil];
                [alert show];
            }];
        }];
    }
}

@end
