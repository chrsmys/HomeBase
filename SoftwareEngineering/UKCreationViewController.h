//
//  UKCreationViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/25/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EDJTable;
@interface UKCreationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *constraintTextField;
@property (weak, nonatomic) IBOutlet UITableView *ukKeyTableView;
@property(nonatomic) EDJTable *table;
@property(nonatomic) NSString *actionColumn;

@end
