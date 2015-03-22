//
//  ColumnCreationViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/16/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EDJTableCreationRequest;

@interface ColumnCreationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *columnListScrollView;
@property (nonatomic) EDJTableCreationRequest *tableRequest;
@end
