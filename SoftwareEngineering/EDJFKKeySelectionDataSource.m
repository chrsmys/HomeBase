//
//  EDJFKKeySelectionDataSource.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/26/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "EDJFKKeySelectionDataSource.h"
#import "EDJListTableTableViewController.h"
#import "EDJColumnTableViewController.h"
#import "EDJTableServices.h"
#import "EDJTable.h"
@implementation EDJFKKeySelectionDataSource

-(instancetype)initWithTable:(EDJTable *)table withColumnsInKey:(NSArray *)selected{
    self=[super init];
    self.table=table;
    self.inKey = [[NSMutableArray alloc] init];
    
    for (int i=0; i<selected.count; i++) {
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setObject:[selected objectAtIndex:i] forKey:@"ColumnName"];
        [self.inKey  addObject:dictionary];
    }
    
    NSMutableArray *not = [[NSMutableArray alloc] initWithArray:[self.table columnNames]];
    [not removeObjectsInArray:selected];

    self.notInKey = [[NSMutableArray alloc] init];

    for (int i=0; i<not.count; i++) {
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setObject:[not objectAtIndex:i] forKey:@"ColumnName"];
        [self.notInKey  addObject:dictionary];
    }
    
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    tableView.allowsSelectionDuringEditing=true;
    _tableview=tableView;
    return [super numberOfSectionsInTableView:tableView];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *nav = [story instantiateViewControllerWithIdentifier:@"ColumnTable"];
    
    UIViewController *content = [[nav viewControllers] firstObject];

    if ([self getTableWithName:self.referencingTable]==nil) {
        nav = [story instantiateViewControllerWithIdentifier:@"TablesView"];
        content = [[nav viewControllers] firstObject];
        EDJListTableTableViewController *contents = (EDJListTableTableViewController *)content;
        contents.shouldGoToColumns=true;
        contents.delegate = self;
    }else{
        EDJColumnTableViewController *contents = (EDJColumnTableViewController *)content;
        contents.table = [self getTableWithName:self.referencingTable];
        contents.delegate = self;
    }
    
    UIPopoverController *popController = [[UIPopoverController alloc] initWithContentViewController:nav];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    CGRect rect = CGRectMake(cell.bounds.origin.x+600, cell.bounds.origin.y+10, 50, 30);
    [popController presentPopoverFromRect:rect inView:cell permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    _lastSelectedIndex = indexPath;
}


-(EDJTable *)getTableWithName:(NSString *)name{
    NSArray *tables = [[EDJTableServices sharedInstance] tables];
    for (EDJTable *table in tables) {
        if ([[table getName] isEqualToString:name]) {
            return table;
        }
    }
    return nil;
}

- (void)didSelectTableWithTableName:(NSString *)tableName withColumnName:(NSString *)columnName{
    NSMutableDictionary *editingDictionary;
    if(_lastSelectedIndex.section==0){
        editingDictionary = [self.inKey objectAtIndex:_lastSelectedIndex.row];
    }else{
        editingDictionary = [self.notInKey objectAtIndex:_lastSelectedIndex.row];
    }
    
    [editingDictionary setObject:columnName forKey:@"RefColumnName"];
    
    [_tableview reloadRowsAtIndexPaths:@[_lastSelectedIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    if (![_referencingTable isEqualToString:tableName]) {
        _referencingTable = tableName;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReferencingNameChaned" object:tableName];
    }
    
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (indexPath.section==0) {
        NSString *none = @"[ Nothing ]";
        if ([[self.inKey objectAtIndex:indexPath.row] objectForKey:@"RefColumnName"]!=nil) {
            none=[[self.inKey objectAtIndex:indexPath.row] objectForKey:@"RefColumnName"];
        }
        NSString *title = [NSString stringWithFormat:@"%@ -> %@",[[self.inKey objectAtIndex:indexPath.row] objectForKey:@"ColumnName"], none];
        cell.textLabel.text = title;
    }else{
        NSString *none = @"[ Nothing ]";
        if ([[self.notInKey objectAtIndex:indexPath.row] objectForKey:@"RefColumnName"]!=nil) {
            none=[[self.notInKey objectAtIndex:indexPath.row] objectForKey:@"RefColumnName"];
        }
        NSString *title = [NSString stringWithFormat:@"%@ -> %@",[[self.notInKey objectAtIndex:indexPath.row] objectForKey:@"ColumnName"], none];
        cell.textLabel.text = title;
    }
    
    
    return cell;
}

-(void)setReferencingTable:(NSString *)referencingTable{
    if (![_referencingTable isEqualToString:referencingTable]) {
        _referencingTable=referencingTable;
        [self clearData];
        [_tableview reloadData];
    }
}

-(void)clearData{
    for (NSMutableDictionary *data  in self.inKey) {
        [data removeObjectForKey:@"RefColumnName"];
    }
    for (NSMutableDictionary *data  in self.notInKey) {
        [data removeObjectForKey:@"RefColumnName"];
    }
}

- (NSMutableDictionary *)consObject{
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    NSMutableArray *cols=[[NSMutableArray alloc] init];
    NSMutableArray *refCols=[[NSMutableArray alloc] init];

    for (NSDictionary *dic in self.inKey) {
        if([dic objectForKey:@"ColumnName"]==nil || [dic objectForKey:@"RefColumnName"]==nil){
            return nil;
        }
        [cols addObject:[dic objectForKey:@"ColumnName"]];
        [refCols addObject:[dic objectForKey:@"RefColumnName"]];
    }
    [dictionary setObject:cols forKey:@"tableCol"];
    [dictionary setObject:self.referencingTable forKey:@"refTable"];
    [dictionary setObject:refCols forKey:@"refCol"];
    
    return dictionary;
}

- (NSString*)dictionaryToJSON:(NSDictionary*)dictionary
{
    NSError* error;
    NSData* data = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    return [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
}


@end
