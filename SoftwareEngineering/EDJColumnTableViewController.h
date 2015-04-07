//
//  EDJColumnTableViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/17/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDJListTableTableViewController.h"
@class EDJTable;
@interface EDJColumnTableViewController : UITableViewController
@property (nonatomic) EDJTable *table;
@property (nonatomic) id<TableSelectionDelegate> delegate;
@property (nonatomic) BOOL editableTable;
@end
