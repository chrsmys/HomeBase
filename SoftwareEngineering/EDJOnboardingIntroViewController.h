//
//  EDJOnboardingIntroViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/27/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDJOnboardingIntroViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *appSummaryLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *homeBaseLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nextButtonTopLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *welcomeTopConstraint;

@end
