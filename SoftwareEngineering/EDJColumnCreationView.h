//
//  EDJColumnCreationView.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/16/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDJColumnCreationView : UIView

@property (weak, nonatomic) IBOutlet UITextField *columnNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *columnSizeTextField;
@property (weak, nonatomic) IBOutlet UITextField *columnTypeTextField;

@property (weak, nonatomic) IBOutlet UIButton *primaryKeyButton;
@property (weak, nonatomic) IBOutlet UIButton *foreignKeyButton;
@property (weak, nonatomic) IBOutlet UIButton *notNullButton;
@property (weak, nonatomic) IBOutlet UIButton *uniqueButton;


@property (nonatomic) BOOL primaryKey;
@property (nonatomic) BOOL foreignKey;
@property (nonatomic) BOOL notNull;
@property (nonatomic) BOOL unique;

- (IBAction)primaryKeyButtonPressed:(UIButton *)sender;
- (IBAction)foreignKeyButtonPressed:(UIButton *)sender;
- (IBAction)notNullButtonPressed:(UIButton *)sender;
- (IBAction)uniqueButtonPressed:(UIButton *)sender;

+(instancetype)getView;
@end
