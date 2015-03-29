//
//  TriggerInfoTableViewCell.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/29/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "TriggerInfoTableViewCell.h"
@interface TriggerInfoTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *activeLabel;
@end
@implementation TriggerInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setActive:(BOOL)active{
    _active=active;
    _activeLabel.textColor = _active ? [UIColor greenColor] : [UIColor redColor];
}
@end
