//
//  EDJPrimaryKeyFinalViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/17/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EDJTableCreationRequest;
@interface EDJPrimaryKeyFinalViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField* constraintNameTextField;
@property (weak, nonatomic) IBOutlet UITextView* primaryKeyListView;
@property (nonatomic) EDJTableCreationRequest* tableRequest;
@property (weak, nonatomic) IBOutlet UITableView *primaryKeyTableView;

@end
