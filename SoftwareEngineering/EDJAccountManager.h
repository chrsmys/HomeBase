//
//  EDJAccountManager.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/14/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDJAccountManager : NSObject{
    NSMutableDictionary *users;
}
-(BOOL)userExists:(NSString *)username;
-(BOOL)loginUserWithUsername:(NSString *)_username password:(NSString *)_password;
-(BOOL)loginUser;
-(BOOL)createUser:(NSString *)username pass:(NSString *)password dbUsername:(NSString *)dbUser dbPassword:(NSString *)dbPassword connectionString:(NSString *)con;
-(void)logoutCurrentUser;
-(void)changeConnectionForCurrentUser:(NSString *)username password:(NSString *)password connectionString:(NSString *)conString;
+ (EDJAccountManager*)sharedInstance;


-(NSMutableArray *)getUserNameList;
-(void)addSchemaToDefaults:(NSDictionary *)dictionary;
-(NSDictionary *)getUserInfoForUsername:(NSString *)username;
@end
