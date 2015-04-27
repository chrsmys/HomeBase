//
//  EDJKeySelectionTableView.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/25/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDJTable.h"
@interface EDJKeySelectionDataSource : NSObject <UITableViewDelegate, UITableViewDataSource>
-(instancetype)initWithTable:(EDJTable *)table withColumnsInKey:(NSArray *)selected;
@property(nonatomic) EDJTable *table;
@property(nonatomic) NSMutableArray *inKey;
@property(nonatomic) NSMutableArray *notInKey;
@end
