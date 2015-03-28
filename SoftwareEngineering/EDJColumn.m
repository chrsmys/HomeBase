//
//  EDJColumn.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/11/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import "EDJColumn.h"

@implementation EDJColumn

@synthesize name=_name;
@synthesize type=_type;
-(id)initWithName:(NSString *)name withType:(NSString *)type{
    if(self=[super init]){
        _name=name;
        _type=type;
    
    }
    return self;
}
@end
