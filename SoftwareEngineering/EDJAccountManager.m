//
//  EDJAccountManager.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/14/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import "EDJAccountManager.h"
#import "NSString+MD5.h"
#import "EDJUser.h"
@implementation EDJAccountManager

static EDJAccountManager *SINGLETON = nil;

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
-(BOOL)createUser:(NSString *)username pass:(NSString *)password dbUsername:(NSString *)dbUser dbPassword:(NSString *)dbPassword connectionString:(NSString *)con{
    if([users objectForKey:username]==nil){
        NSMutableDictionary *user=[[NSMutableDictionary alloc] init];
        [user setObject:[password MD5String] forKey:@"password"];
        [user setObject:username forKey:@"username"];
        [user setObject:con forKey:@"connection-string"];
        [user setObject:dbUser forKey:@"db-username"];
        [user setObject:dbPassword forKey:@"db-password"];
        [users setObject:user forKey:username];
        [self addUserToDefaults:user];
        return true;
    }
    return false;
}

-(BOOL)userExists:(NSString *)username{
    return [users objectForKey:username]!=nil;
}
-(BOOL)loginUserWithUsername:(NSString *)_username password:(NSString *)_password{
    users=[[NSMutableDictionary alloc]  initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"Users"]];
    if([users objectForKey:_username]!=nil){
        NSString *password=[[users objectForKey:_username] objectForKey:@"password"];
        if([[_password MD5String] isEqualToString:password]){
            return [[EDJUser sharedInstance] setUserInfo:[users objectForKey:_username]];
            
        }else{
            return false;
        }
    }
    return false;
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
    return [[EDJAccountManager alloc] init];
}

- (id)mutableCopy
{
    return [[EDJAccountManager alloc] init];
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
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"Users"]==nil){
        [defaults setObject:[[NSMutableDictionary alloc] init] forKey:@"Users"];
    }
    users=[[NSMutableDictionary alloc]  initWithDictionary:[defaults objectForKey:@"Users"]];

    return self;
}

#pragma mark Helper Methods
-(void)addUserToDefaults:(NSMutableDictionary *)dic{
    //[[[NSUserDefaults standardUserDefaults] objectForKey:@"Users"] setObject:dic forKey:[dic objectForKey:@"username"]];
    NSMutableDictionary *array=[[NSMutableDictionary alloc] initWithDictionary:(NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:@"Users"]];
    [array setObject:[[NSMutableDictionary alloc] initWithDictionary:dic] forKey:[dic objectForKey:@"username"]];
    NSLog(@"username %@",[dic objectForKey:@"username"]);
    [[NSUserDefaults standardUserDefaults] setObject:[[NSMutableDictionary alloc] initWithDictionary:array] forKey:@"Users"];
    
    
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)changeConnectionForCurrentUser:(NSString *)_username password:(NSString *)_password connectionString:(NSString *)conString{
    NSMutableDictionary *currenUserDict=[[NSMutableDictionary alloc] initWithDictionary:[[EDJUser sharedInstance] getDictionaryForUser]];
    [currenUserDict setObject:conString forKey:@"connection-string"];
    [currenUserDict setObject:_username forKey:@"db-username"];
    [currenUserDict setObject:_password forKey:@"db-password"];
    [self addUserToDefaults:currenUserDict];
    if([[EDJUser sharedInstance] setUserInfo:[[[NSUserDefaults standardUserDefaults] objectForKey:@"Users"] objectForKey:@"Dave"]]){
    }
    
    
}
-(void)logoutCurrentUser{
    [[EDJUser sharedInstance] logout];
    
}
@end
