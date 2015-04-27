//
//  NotNullCreationViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/25/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "ViewController.h"

@interface NotNullCreationViewController : ViewController
@property(nonatomic) EDJTable *table;
@property(nonatomic) NSString *actionColumn;
@property (weak, nonatomic) IBOutlet UITextField *constrainNameTextField;

@end
