//
//  EDJColumnTableViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/17/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "EDJColumnTableViewController.h"
#import "EDJTable.h"
#import "EDJColumn.h"
#import "ColumnTableViewCell.h"
#import "EDJTableServices.h"
#import "MGSwipeButton.h"
#import "AddNewColumnViewController.h"
@interface EDJColumnTableViewController ()

@end

@implementation EDJColumnTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.editableTable ? [[self.table getColumns] count] + 1 : [[self.table getColumns] count];
}

- (BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath
{
    // Return YES if you want the specified item to be editable.
    return self.editableTable && indexPath.row != [[self.table getColumns] count];
}
- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EDJColumn* column = [[self.table getColumns] objectAtIndex:indexPath.row];
        [[EDJTableServices sharedInstance] dropColumn:[column name] withTableName:self.table.getName withCompletion:^(BOOL finished) {
            [self.table removeColumnWithIndex:indexPath.row];
            NSLog(@"Finished %d", [[self.table getColumns] count]);
         
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView beginUpdates];
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                [self.tableView endUpdates];
            });

        } withError:^(NSString* error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"Done" otherButtonTitles: nil];
                [alert show];
            }];
        }];
    }
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (!self.editableTable || indexPath.row != [[self.table getColumns] count]) {
        ColumnTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"columnCell" forIndexPath:indexPath];
        EDJColumn* column = [[self.table getColumns] objectAtIndex:indexPath.row];
        cell.columnNameLabel.text = [column name];
        cell.typeLabel.text = [column formattedType];
        cell.constraintLabel.text = @"";
        if (self.editableTable) {
            cell.leftButtons = @[ [MGSwipeButton buttonWithTitle:@" Constraint " backgroundColor:[UIColor colorWithRed:0.125 green:0.42 blue:0.608 alpha:1]], [MGSwipeButton buttonWithTitle:@"edit" backgroundColor:[UIColor orangeColor] callback:^BOOL(MGSwipeTableCell* sender) {
                [self performSegueWithIdentifier:@"AddNewColumn" sender:[NSNumber numberWithInt:indexPath.row]];
                return true;
            }] ];
            cell.leftExpansion = [[MGSwipeExpansionSettings alloc] init];
            cell.leftExpansion.buttonIndex = 1;
        }
        if ([self.table isPrimaryKey:[column name]]) {
            cell.constraintLabel.text = [NSString stringWithFormat:@"%@ %@", cell.constraintLabel.text, @"PK"];
        }
        return cell;
    }
    else {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"NewColumn" forIndexPath:indexPath];
        return cell;
    }
}

- (void)setEditableTable:(BOOL)editableTable
{
    _editableTable = editableTable;
    [self.tableView reloadData];
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (!self.editableTable || indexPath.row != [[self.table getColumns] count]) {
        [self.delegate didSelectTableWithTableName:[self.table getName] withColumnName:[[[self.table getColumns] objectAtIndex:indexPath.row] name]];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self performSegueWithIdentifier:@"AddNewColumn" sender:nil];
    }
}

- (void)setTable:(EDJTable*)table
{
    _table = table;
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddNewColumn"]) {
        UIViewController* destination = segue.destinationViewController;
        if ([destination isKindOfClass:[UINavigationController class]]) {
            destination = [[((UINavigationController*)destination)viewControllers] objectAtIndex:0];
        }
        if ([destination isKindOfClass:[AddNewColumnViewController class]]) {

            AddNewColumnViewController* columnView = (AddNewColumnViewController*)destination;
            columnView.table = self.table;
            if (sender != nil) {
                EDJColumn* column = [[self.table getColumns] objectAtIndex:[sender intValue]];
                columnView.column = column;
            }
        }
    }
}

@end
