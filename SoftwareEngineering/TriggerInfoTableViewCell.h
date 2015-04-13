//
//  TriggerInfoTableViewCell.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/29/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TriggerInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel* triggerNameLabel;
@property (nonatomic, getter=isActive) BOOL active;
@end
