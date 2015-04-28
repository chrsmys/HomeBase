//
//  EDJOnboardingIntroViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/27/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "EDJOnboardingIntroViewController.h"

@interface EDJOnboardingIntroViewController ()

@end

@implementation EDJOnboardingIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.125 green:0.42 blue:0.608 alpha:1];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    self.homeBaseLabel.textColor=[UIColor colorWithRed:0.871 green:0.933 blue:0.988 alpha:1];
     self.welcomeLabel.textColor=[UIColor colorWithRed:0.871 green:0.933 blue:0.988 alpha:1];
    self.appSummaryLabel.textColor= self.welcomeLabel.textColor=[UIColor colorWithRed:0.871 green:0.933 blue:0.988 alpha:1];
    self.nextButton.titleLabel.textColor=[UIColor colorWithRed:0.953 green:0.533 blue:0.388 alpha:1];
}
-(void)viewDidAppear:(BOOL)animated{
    self.nextButtonTopLayoutConstraint.constant+=30;
    [UIView animateWithDuration:0.5 animations:^(void){
        self.welcomeLabel.alpha=1;
    }completion:^(BOOL finished){
        [UIView animateWithDuration:0.5 animations:^(void){
            self.appSummaryLabel.alpha=1;
        }completion:^(BOOL finished){
            [UIView animateWithDuration:0.5 animations:^(void){
                self.nextButton.alpha=1;
                self.nextButtonTopLayoutConstraint.constant+=30;
                self.welcomeTopConstraint.constant+=30;
                [self.view layoutIfNeeded];
            }completion:^(BOOL finished){
                
            }];
        }];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
