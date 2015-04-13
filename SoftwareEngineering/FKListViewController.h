//
//  FKListViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/17/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FKListViewController : UIViewController
- (IBAction)doneButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView* FKTextView;
@property (nonatomic) NSString* fkText;
@end
