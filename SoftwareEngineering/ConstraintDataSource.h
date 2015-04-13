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
@interface ConstraintDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) EDJTable* table;
@end
