//
//  EDJTrigger.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/29/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDJTrigger : NSObject
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *type;
@property(nonatomic, strong) NSString *event;
@property(nonatomic, strong) NSString *status;
@property(nonatomic, strong) NSString *body;
@property(nonatomic, getter=isActive) BOOL active;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
