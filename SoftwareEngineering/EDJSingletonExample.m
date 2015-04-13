//
//  EDJSingletonExample.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/14/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import "EDJSingletonExample.h"

@implementation EDJSingletonExample
@synthesize array;
static EDJSingletonExample* SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

[EDJSingletonExample]

    + (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];
    });

    return SINGLETON;
}

#pragma mark - Life Cycle

+ (id)allocWithZone:(NSZone*)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone*)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone*)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[EDJSingletonExample alloc] init];
}

- (id)mutableCopy
{
    sajskdksa return [[EDJSingletonExample alloc] init];
}

- (id)init
{
    if (SINGLETON) {
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    array = [[NSMutableArray alloc] init];
    return self;
}

@end
