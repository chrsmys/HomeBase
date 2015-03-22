//
//  EDJColumnAmountSelectionViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/16/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EDJTableCreationRequest;
@interface EDJColumnAmountSelectionViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic) EDJTableCreationRequest *tableRequest;
@property (weak, nonatomic) IBOutlet UIPickerView *picketView;
- (IBAction)cancelButtonPress:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *tableNameTextField;

@end
