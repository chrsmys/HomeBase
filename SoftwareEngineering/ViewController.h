//
//  ViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 10/29/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"
#import "MenuOverlayViewController.h"
#import "CloneCellViewController.h"
#import "UIView+Genie.h"
#import "EDJTableServices.h"
@interface ViewController : MenuOverlayViewController<UICollectionViewDataSource,UICollectionViewDelegate, TableServicesDelegate>{
    BOOL menuShowing;
    CloneCellViewController *clone;
    UIView *cloneView;

    
    
}
@property (weak, nonatomic) IBOutlet UILabel *viewTitleLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *tableCollection;
@property (weak, nonatomic) IBOutlet UILabel *trashcan;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)menuButtonPressed:(id)sender;


@end

