//
//  ConstraintDataSource.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/7/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EDJTable.h"
#import "EDJConstraint.h"
@protocol ConstraintInfoDelegate
- (void)selectedConstraint:(EDJConstraint*)constrain;
@end
@interface ConstraintDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) EDJTable* table;
@property (nonatomic, weak) NSObject<ConstraintInfoDelegate>* delegate;
@property (nonatomic) NSMutableArray *uniqueConstraints;
@end
