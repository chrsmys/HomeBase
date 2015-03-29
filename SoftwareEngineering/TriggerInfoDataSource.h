//
//  TriggerInfoDataSource.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/29/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EDJTable.h"
@interface TriggerInfoDataSource : NSObject<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) EDJTable *table;
@end
