//
//  EditTableNameViewController.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/6/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditTableNameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *tableNameTextField;
@property (weak, nonatomic) NSString *tableName;
@end
