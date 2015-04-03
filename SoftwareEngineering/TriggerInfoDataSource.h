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
@class EDJTrigger;
@protocol TriggerInfoDelegate
-(void)selectedTrigger:(EDJTrigger *)trigger;
@end
@interface TriggerInfoDataSource : NSObject<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) EDJTable *table;
@property (nonatomic, weak) NSObject<TriggerInfoDelegate>* delegate;
@end
