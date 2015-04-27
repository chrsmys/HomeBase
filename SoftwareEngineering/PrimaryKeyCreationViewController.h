//
//  PrimaryKeyCreationViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/26/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDJTable.h"
@interface PrimaryKeyCreationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *constraintNameTextField;
@property (weak, nonatomic) IBOutlet UITableView *keySelectionTableView;
@property(nonatomic) EDJTable *table;
@property(nonatomic) NSString *actionColumn;
@end
