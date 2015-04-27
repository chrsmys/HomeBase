//
//  FKCreationViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/26/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "ViewController.h"
#import "EDJListTableTableViewController.h"
@interface FKCreationViewController : ViewController<TableSelectionDelegate>
@property(nonatomic) EDJTable *table;
@property(nonatomic) NSString *actionColumn;
@property (weak, nonatomic) IBOutlet UITextField *constraintNameTextField;
@property (weak, nonatomic) IBOutlet UITableView *keyCreationTableView;
@property (weak, nonatomic) IBOutlet UIButton *referencingTableButton;
@property (weak, nonatomic) IBOutlet UISwitch *deferrableSwitch;

@end
