//
//  TableInfoViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/28/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDJTable.h"
#import "TriggerInfoDataSource.h"
@class EDJTrigger;
@interface TableInfoViewController : UIViewController <TriggerInfoDelegate> {
    EDJTrigger* selectedTrigger;
}
@property (nonatomic, strong) EDJTable* table;
@property (weak, nonatomic) IBOutlet UITextView* foreignKeyInfoTextView;
@property (weak, nonatomic) IBOutlet UIView* columnTableViewContainer;
@property (weak, nonatomic) IBOutlet UITableView* triggerInfoTableView;
@property (weak, nonatomic) IBOutlet UITableView* constraintTableView;
@end
