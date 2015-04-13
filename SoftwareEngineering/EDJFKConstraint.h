//
//  EDJFKConstraint.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/17/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EDJFKConstraint;
@protocol EDJFKConstraintDelegate <NSObject>

- (void)didSelectTableViewWithConstraint:(EDJFKConstraint*)constraint;

@end

@interface EDJFKConstraint : UIView

@property (nonatomic) id<EDJFKConstraintDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel* fkColumnName;
@property (weak, nonatomic) IBOutlet UITextField* constraintNameTextField;
@property (weak, nonatomic) IBOutlet UIButton* selectTableButton;
@property (weak, nonatomic) IBOutlet UISwitch* deferableSwitch;
@property (nonatomic) NSString* refrencingTableName;
@property (nonatomic) NSString* refrencingColumnName;

- (IBAction)deferableDidSwitch:(UISwitch*)sender;
- (IBAction)selectTablePressed:(UIButton*)sender;

+ (instancetype)getView;

@end
