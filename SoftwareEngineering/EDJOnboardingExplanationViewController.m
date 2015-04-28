//
//  EDJOnboardingExplanationViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/27/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "EDJOnboardingExplanationViewController.h"

@interface EDJOnboardingExplanationViewController ()

@end

@implementation EDJOnboardingExplanationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    self.leftImageTopConstraint.constant-=45;
    self.rightImageTopConstraint.constant-=45;
    [UIView animateWithDuration:0.5 animations:^(void){
        self.ExplanationTopLabel.alpha=1;
    }completion:^(BOOL finished){
        
        [UIView animateWithDuration:0.5 animations:^(void){
            self.leftImageTopConstraint.constant+=45;
            self.leftImage.alpha=1.0;
            [self.view layoutIfNeeded];
        }completion:^(BOOL finished){
            [UIView animateWithDuration:0.5 animations:^(void){
                self.rightImageTopConstraint.constant+=45;
                self.rightImage.alpha=1.0;
                [self.view layoutIfNeeded];
            }completion:^(BOOL finished){
                [UIView animateWithDuration:0.5 animations:^(void){
                    self.nextButton.alpha=1;
                }completion:^(BOOL finished){
                    
                }];
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