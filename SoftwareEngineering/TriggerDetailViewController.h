//
//  TriggerDetailViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/1/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDJTrigger.h"
@interface TriggerDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *triggerCodeDisplay;
@property(nonatomic) EDJTrigger *trigger;
@end
