//
//  EDJTableSubmissionViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/17/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EDJTableCreationRequest;
@interface EDJTableSubmissionViewController : UIViewController
@property (nonatomic) EDJTableCreationRequest *tableRequest;

-(void)performAction:(void (^)(UIViewController *currentView))action;

@end
