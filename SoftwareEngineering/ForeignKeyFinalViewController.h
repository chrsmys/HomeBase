//
//  ForeignKeyFinalViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/17/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDJFKConstraint.h"
#import "EDJListTableTableViewController.h"
@class EDJTableCreationRequest;
@class EDJFKConstraint;
@interface ForeignKeyFinalViewController : UIViewController<EDJFKConstraintDelegate, TableSelectionDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *fkConstraintsScrollView;
@property (nonatomic) EDJTableCreationRequest *tableRequest;
@property (nonatomic) EDJFKConstraint *lastTouched;
@end
