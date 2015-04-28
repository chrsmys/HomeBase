//
//  ConstraintsInfoViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/27/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDJConstraint.h"
@interface ConstraintsInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *constraintInfoTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic) EDJConstraint *constraint;
@end
