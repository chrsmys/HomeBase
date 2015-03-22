//
//  EDJTableSubmissionViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/17/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "EDJTableSubmissionViewController.h"
#import "EDJTableServices.h"
#import "EDJTableCreationRequest.h"
@interface EDJTableSubmissionViewController ()

@end

@implementation EDJTableSubmissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"Final %@", [self.tableRequest getNetworkJSONRequest]);
    [[EDJTableServices sharedInstance] addTableWithRequest:self.tableRequest withCompletion:^(BOOL finished){
         dispatch_async(dispatch_get_main_queue(), ^{
             [self dismissViewControllerAnimated:YES completion:nil];
         });
    }
    withError:^(NSString *error){
        [self.navigationController popViewControllerAnimated:YES];
        
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
