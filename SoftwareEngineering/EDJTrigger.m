//
//  EDJTrigger.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/29/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "EDJTrigger.h"
#import "AppConstants.h"
@interface EDJTrigger ()
@property (nonatomic, strong) NSDictionary *valueDictionary;
@end
@implementation EDJTrigger
-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self=[super init];
    _valueDictionary=dictionary;
    return self;
}
-(NSString *)name{
    return [_valueDictionary objectForKey:TRIGGER_NAME];
}

-(NSString *)type{
    return [_valueDictionary objectForKey:TRIGGER_TYPE];
}

-(NSString *)event{
    return [_valueDictionary objectForKey:TRIGGERING_EVENT];
}

-(NSString *)status{
    return [_valueDictionary objectForKey:TRIGGER_STATUS];
}

-(NSString *)body{
    return [_valueDictionary objectForKey:TRIGGER_BODY];
}
-(BOOL)isActive{
    return [[self status] isEqualToString:TRIGGER_STATUS_ACTIVE];
}
@end
