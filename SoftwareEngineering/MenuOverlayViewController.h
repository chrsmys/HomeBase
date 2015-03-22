//
//  MenuOverlayViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/17/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MenuButtonDelegate
-(void)menuButtonWasPressed;
@end

@interface MenuOverlayViewController : UIViewController <MenuButtonDelegate>{
    
}
-(void)editConnectionButtonPressed;
@property (strong, nonatomic) id delegate;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@end
