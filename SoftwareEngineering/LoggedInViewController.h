//
//  LoggedInViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/17/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@interface LoggedInViewController : UIViewController<MenuButtonDelegate,MenuDelegate>{
    BOOL menuShowing;
}
@property (weak, nonatomic) IBOutlet UIView *topContainer;
@property (weak, nonatomic) IBOutlet UIView *menuContainer;

@end
