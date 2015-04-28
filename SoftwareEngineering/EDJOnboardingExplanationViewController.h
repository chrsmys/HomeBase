//
//  EDJOnboardingExplanationViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/27/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDJOnboardingExplanationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *ExplanationTopLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftImageTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightImageTopConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;


@end
