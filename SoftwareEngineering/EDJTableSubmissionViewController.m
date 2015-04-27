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

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)viewDidAppear:(BOOL)animated
{
    if (self.tableRequest) {
        [[EDJTableServices sharedInstance] addTableWithRequest:self.tableRequest withCompletion:^(BOOL finished) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self dismissViewControllerAnimated:YES completion:nil];
             });
        }
            withError:^(NSString* error) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:error delegate:nil cancelButtonTitle:@"Done" otherButtonTitles: nil];
                 [alert show];
                 [self.navigationController popViewControllerAnimated:YES];
             });
            }];
    }
}

- (void)performAction:(void (^)(UIViewController* currentView))action
{
    action(self);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
