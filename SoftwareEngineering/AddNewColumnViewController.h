//
//  AddNewColumnViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/5/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDJColumnCreationView.h"
#import "EDJTable.h"
#import "EDJColumn.h"
@interface AddNewColumnViewController : UIViewController
@property(nonatomic, retain) EDJColumnCreationView *columnCreationView;
@property(nonatomic, retain) EDJTable *table;
@property(nonatomic,retain)  EDJColumn *column;
@end
