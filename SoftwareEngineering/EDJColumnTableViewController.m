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
@interface EDJColumnTableViewController ()

@end

@implementation EDJColumnTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
    self.tableView.allowsMultipleSelectionDuringEditing = NO;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.table getColumns] count];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EDJColumn *column = [[self.table getColumns] objectAtIndex:indexPath.row];
        [[EDJTableServices sharedInstance] dropColumn:[column name] withTableName:self.table.getName withCompletion:^(BOOL finished){
            [self.table removeColumnWithIndex:indexPath.row];
            NSLog(@"Finished %d", [[self.table getColumns] count]);
         
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView beginUpdates];
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                [self.tableView endUpdates];
            });

        } withError:nil];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ColumnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"columnCell" forIndexPath:indexPath];
    EDJColumn *column = [[self.table getColumns] objectAtIndex:indexPath.row];
    cell.columnNameLabel.text=[column name];
    cell.typeLabel.text=[column formattedType];
    cell.constraintLabel.text = @"";
    cell.leftButtons = @[[MGSwipeButton buttonWithTitle:@" Constraint " backgroundColor:[UIColor colorWithRed:0.125 green:0.42 blue:0.608 alpha:1]], [MGSwipeButton buttonWithTitle:@"edit" backgroundColor:[UIColor orangeColor]]];
    cell.leftExpansion = [[MGSwipeExpansionSettings alloc] init];
    cell.leftExpansion.buttonIndex=1;
    if([self.table isPrimaryKey:[column name]]){
        cell.constraintLabel.text = [NSString stringWithFormat:@"%@ %@", cell.constraintLabel.text ,@"PK"];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate didSelectTableWithTableName:[self.table getName] withColumnName:[[[self.table getColumns] objectAtIndex:indexPath.row] name]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setTable:(EDJTable *)table{
    _table=table;
    [self.tableView reloadData];
}

@end
