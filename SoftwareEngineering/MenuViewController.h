//
//  MenuViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/17/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@protocol MenuDelegate
-(void)editConnectionButtonPressed;
-(void)logoutButtonPressed;
@end
@interface MenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *menuItems;
}
@property (weak,nonatomic) id delegate;
@end
