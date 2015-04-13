//
//  ConstraintTableViewCell.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/7/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConstraintTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel* constraintNameLabel;
@property (weak, nonatomic) IBOutlet UILabel* tableColumnLabel;
@property (nonatomic) BOOL enabled;
@end
