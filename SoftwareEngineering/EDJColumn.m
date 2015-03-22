//
//  EDJColumn.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/11/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import "EDJColumn.h"

@implementation EDJColumn

@synthesize name;

-(id)initWithName:(NSString *)_names withType:(NSString *)_type{
    if(self=[super init]){
        name=_names;
        type=_type;
    }
    return self;
}
@end
