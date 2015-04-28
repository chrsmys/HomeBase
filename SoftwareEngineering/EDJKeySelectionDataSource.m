//
//  EDJKeySelectionTableView.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/25/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "EDJKeySelectionDataSource.h"
@interface EDJKeySelectionDataSource ()
@end

@implementation EDJKeySelectionDataSource
@synthesize notInKey = _notInKey;

-(instancetype)initWithTable:(EDJTable *)table withColumnsInKey:(NSArray *)selected{
    self=[super init];
    self.table=table;
    self.inKey = [[NSMutableArray alloc] initWithArray:selected];
    self.notInKey = [[NSMutableArray alloc] initWithArray:[self.table columnNames]];
    [self.notInKey removeObjectsInArray:self.inKey];
    return self;
}
-(instancetype)initWithArray:(NSArray *)table withColumnsInKey:(NSArray *)selected{
        self=[super init];
        self.inKey = [[NSMutableArray alloc] initWithArray:selected];
        self.notInKey = [[NSMutableArray alloc] initWithArray:table];
        [self.notInKey removeObjectsInArray:self.inKey];
        return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    tableView.editing=true;
    return 2;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return [self.inKey count];
    }
    return [self.notInKey count];
}

- (BOOL)tableView:(UITableView*)tableView canMoveRowAtIndexPath:(NSIndexPath*)indexPath
{
    return true;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
   
    if (indexPath.section==0) {
        cell.textLabel.text = [self.inKey objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text = [self.notInKey objectAtIndex:indexPath.row];
    }
    

    return cell;
}
- (void)tableView:(UITableView*)tableView moveRowAtIndexPath:(NSIndexPath*)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
    id columnName = @"";
    if (sourceIndexPath.section==0) {
        columnName = [self.inKey objectAtIndex:sourceIndexPath.row];
        [self.inKey removeObject:columnName];
    }else{
        columnName = [self.notInKey objectAtIndex:sourceIndexPath.row];
        [self.notInKey removeObject:columnName];
    }
    
    if (destinationIndexPath.section==0) {
        [self.inKey insertObject:columnName atIndex:destinationIndexPath.row];
    }else{
        [self.notInKey insertObject:columnName atIndex:destinationIndexPath.row];
    }
    
}
- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"In Key";
    }
    else {
        return @"Not In Key";
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return UITableViewCellEditingStyleNone;
}

@end
