//
//  EDJConnection.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/11/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol EDJConnectionDelegate
-(void)connectionReturnedValidObject:(NSString *)JSON;
-(void)connectionReturnedInValidObject:(NSString *)JSON;
-(void)connectionReturnedError:(NSError *)error WithObject:(NSString *)JSON;
-(void)connectionReturnedTableList:(NSMutableArray *)tlList;
@end
@interface EDJConnection : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>{
    NSURLConnection *connection;
    NSMutableData *conData;
}
@property (nonatomic, weak) id delegate;
-(void)getTablesForUserWithUsername:(NSString *)username withPassword:(NSString *)passwor withConnectionString:(NSString *)con;
//
@end
