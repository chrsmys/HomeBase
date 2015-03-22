//
//  EDJUser.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/14/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDJUser : NSObject{
BOOL containsUser;
    NSString *username;
    NSString *password;
    NSString *connectionString;
    NSString *dbUsername;
    NSString *dbPassword;
}

/**
 * gets singleton object.
 * @return singleton
 */
+ (EDJUser*)sharedInstance;
-(void)clearUserInfo;
-(BOOL)setUserInfo:(NSMutableDictionary *)userInfo;
-(BOOL)containsUser;
-(NSString *)getConnectionString;
-(NSString *)getDBUsername;
-(NSString *)getDBPassword;
-(void)logout;
-(NSMutableDictionary *)getDictionaryForUser;


@end
