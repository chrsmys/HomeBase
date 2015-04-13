//
//  EDJFKConstraint.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/17/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "EDJFKConstraint.h"

@implementation EDJFKConstraint

+ (instancetype)getView
{
    EDJFKConstraint* view = [[[NSBundle mainBundle] loadNibNamed:@"EDJFKConstraint" owner:self options:nil] firstObject];
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)deferableDidSwitch:(UISwitch*)sender
{
}

- (IBAction)selectTablePressed:(UIButton*)sender
{
    [self.delegate didSelectTableViewWithConstraint:self];
}
@end
