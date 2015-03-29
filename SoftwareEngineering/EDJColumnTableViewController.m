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
@interface EDJColumnTableViewController ()

@end

@implementation EDJColumnTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.table getColumns] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ColumnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"columnCell" forIndexPath:indexPath];
    EDJColumn *column = [[self.table getColumns] objectAtIndex:indexPath.row];
    cell.columnNameLabel.text=[column name];
    cell.typeLabel.text=[column type];
    cell.constraintLabel.text = @"";
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
