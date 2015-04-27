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
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    [UIView animateWithDuration:0.5 animations:^(void){
        self.welcomeLabel.alpha=1;
    }completion:^(BOOL finished){
        [UIView animateWithDuration:0.5 animations:^(void){
            self.appSummaryLabel.alpha=1;
        }completion:^(BOOL finished){
            [UIView animateWithDuration:0.5 animations:^(void){
                self.nextButton.alpha=1;
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
