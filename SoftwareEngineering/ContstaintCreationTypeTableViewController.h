//
//  ContstaintCreationTypeTableViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/25/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EDJTable;
@interface ContstaintCreationTypeTableViewController : UITableViewController
@property(nonatomic) EDJTable *table;
@property(nonatomic) NSString *actionColumn;
- (IBAction)cancelButtonPressed:(id)sender;
@end
