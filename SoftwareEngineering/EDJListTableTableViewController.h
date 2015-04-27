//
//  EDJListTableTableViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/17/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TableSelectionDelegate
- (void)didSelectTableWithTableName:(NSString*)tableName withColumnName:(NSString*)columnName;
- (void)didSelectTableWithTableName:(NSString *)tableName;
@end
@interface EDJListTableTableViewController : UITableViewController
@property (nonatomic) id<TableSelectionDelegate> delegate;
@property (nonatomic) BOOL shouldGoToColumns;
@end
