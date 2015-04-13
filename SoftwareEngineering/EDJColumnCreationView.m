//
//  EDJColumnCreationView.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/16/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "EDJColumnCreationView.h"

@implementation EDJColumnCreationView

- (IBAction)primaryKeyButtonPressed:(UIButton*)sender
{
    [self setPrimaryKey:!self.primaryKey];
    if ([self primaryKey]) {
        self.notNull = true;
        self.unique = true;
    }
    [self updateUI];
}

- (IBAction)foreignKeyButtonPressed:(UIButton*)sender
{
    [self setForeignKey:!self.foreignKey];
    [self updateUI];
}

- (IBAction)notNullButtonPressed:(UIButton*)sender
{
    [self setNotNull:!self.notNull];
    [self updateUI];
}

- (IBAction)uniqueButtonPressed:(UIButton*)sender
{
    [self setUnique:!self.unique];
    [self updateUI];
}

- (void)updateUI
{

    NSString* primaryKeyText = [NSString stringWithFormat:@"%@ Primary Key", (self.primaryKey ? @"\uf046" : @"\uf096")];
    NSString* foreignKeyText = [NSString stringWithFormat:@"%@ Foreign Key", (self.foreignKey ? @"\uf046" : @"\uf096")];
    NSString* notNullText = [NSString stringWithFormat:@"%@ Not Null", (self.notNull ? @"\uf046" : @"\uf096")];
    NSString* uniqueText = [NSString stringWithFormat:@"%@ Unique", (self.unique ? @"\uf046" : @"\uf096")];

    [self.primaryKeyButton setTitle:primaryKeyText forState:UIControlStateNormal];
    [self.foreignKeyButton setTitle:foreignKeyText forState:UIControlStateNormal];
    [self.notNullButton setTitle:notNullText forState:UIControlStateNormal];
    [self.uniqueButton setTitle:uniqueText forState:UIControlStateNormal];
}

+ (instancetype)getView
{
    EDJColumnCreationView* view = [[[NSBundle mainBundle] loadNibNamed:@"EDJColumnCreationView" owner:self options:nil] firstObject];
    [view setUnique:false];
    [view setForeignKey:false];
    [view setPrimaryKey:false];
    [view setNotNull:false];
    [view updateUI];
    return view;
}

+ (instancetype)getViewWithOutFKAddition
{
    EDJColumnCreationView* view = [[[NSBundle mainBundle] loadNibNamed:@"EDJColumnCreationView" owner:self options:nil] firstObject];
    [view setUnique:false];
    [view setForeignKey:false];
    [view setPrimaryKey:false];
    [view setNotNull:false];
    [view updateUI];
    [[view foreignKeyButton] setHidden:true];
    [[view primaryKeyButton] setHidden:true];

    return view;
}

@end
