//
//  ConstraintTableViewCell.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/7/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "ConstraintTableViewCell.h"
@interface ConstraintTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel* enabledLabel;

@end
@implementation ConstraintTableViewCell
@synthesize enabled = _enabled;
- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    _enabledLabel.textColor = _enabled ? [UIColor greenColor] : [UIColor redColor];
}

@end
