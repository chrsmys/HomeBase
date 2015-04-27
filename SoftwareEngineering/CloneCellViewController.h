//
//  CloneCellViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/20/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDJTable.h"
@interface CloneCellViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView* tableInfoContainer;
@property (strong, nonatomic) IBOutlet UIView* cloneCellView;
@property (weak, nonatomic) IBOutlet UILabel* tableNameLabel;
@property (weak, nonatomic) UICollectionViewCell* clonedCell;
@property (weak, nonatomic) IBOutlet UITextView* columnsListView;
@property (strong, nonatomic) EDJTable* table;
@property (weak, nonatomic) UITextView* foriegnKeysList;
@property (weak, nonatomic) IBOutlet UIView* containerView;

@end
