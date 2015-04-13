//
//  ColumnTableViewCell.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/28/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"
@interface ColumnTableViewCell : MGSwipeTableCell
@property (weak, nonatomic) IBOutlet UILabel* columnNameLabel;
@property (weak, nonatomic) IBOutlet UILabel* typeLabel;
@property (weak, nonatomic) IBOutlet UILabel* constraintLabel;

@end
