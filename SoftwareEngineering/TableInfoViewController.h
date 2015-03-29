//
//  TableInfoViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/28/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDJTable.h"
@interface TableInfoViewController : UIViewController
@property(nonatomic,strong) EDJTable *table;
@property (weak, nonatomic) IBOutlet UITextView *foreignKeyInfoTextView;
@end
