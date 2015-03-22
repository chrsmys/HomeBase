//
//  EDJUser.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/14/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import "EDJUser.h"

@implementation EDJUser

static EDJUser *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];
    });
    
    return SINGLETON;
}
-(BOOL)setUserInfo:(NSMutableDictionary *)userInfo{
    if([userInfo objectForKey:@"username"]!=nil){
        username=[userInfo objectForKey:@"username"];
    }else{
        [self clearUserInfo];
        return false;
    }
    if([userInfo objectForKey:@"connection-string"]!=nil){
        connectionString=[userInfo objectForKey:@"connection-string"];
    }else{
        [self clearUserInfo];
        return false;
    }
    if([userInfo objectForKey:@"password"]!=nil){
        password=[userInfo objectForKey:@"password"];
    }else{
        [self clearUserInfo];
        return false;
    }
    if([userInfo objectForKey:@"db-password"]!=nil){
        dbPassword=[userInfo objectForKey:@"db-password"];
    }else{
        [self clearUserInfo];
        return false;
    }
    if([userInfo objectForKey:@"db-username"]!=nil){
        dbUsername=[userInfo objectForKey:@"db-username"];
    }else{
        [self clearUserInfo];
        return false;
    }
    containsUser=true;
    return true;
}
-(NSMutableDictionary *)getDictionaryForUser{
    NSMutableDictionary *user=[[NSMutableDictionary alloc] init];
    [user setObject:password forKey:@"password"];
    [user setObject:username forKey:@"username"];
    [user setObject:connectionString forKey:@"connection-string"];
    [user setObject:dbUsername forKey:@"db-username"];
    [user setObject:dbPassword forKey:@"db-password"];
    
    NSLog(@"%d",[[user allKeys] count]);

    return user;
}
-(void)clearUserInfo{
    containsUser=false;
    username=@"";
    password=@"";
    dbPassword=@"";
    dbUsername=@"";
    connectionString=@"";
}
-(void)logout{
    [self clearUserInfo];
}
-(BOOL)containsUser{
    return containsUser;
}
-(NSString *)getConnectionString{
    return connectionString;
}
-(NSString *)getDBUsername{
    return dbUsername;
}
-(NSString *)getDBPassword{
    return dbPassword;
}
#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[EDJUser alloc] init];
}

- (id)mutableCopy
{
    return [[EDJUser alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    containsUser=false;
    
    return self;
}

@end
