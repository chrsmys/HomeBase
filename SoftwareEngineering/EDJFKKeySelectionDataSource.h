//
//  EDJFKKeySelectionDataSource.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/26/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "EDJKeySelectionDataSource.h"
#import "EDJListTableTableViewController.h"
@interface EDJFKKeySelectionDataSource : EDJKeySelectionDataSource<TableSelectionDelegate>{
    NSIndexPath *_lastSelectedIndex;
    UITableView *_tableview;
}
@property(nonatomic) NSString *referencingTable;
- (NSMutableDictionary *)consObject;
@end
