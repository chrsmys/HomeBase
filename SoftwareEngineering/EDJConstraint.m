//
//  EDJConstraint.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/6/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "EDJConstraint.h"
@interface EDJConstraint ()
@property(nonatomic) NSDictionary *constraintDetails;
@end
/*
 {"TABLE_NAME":"TEST_TABLE_6","COLUMN_NAME":"COL_1","POSITION":"1","STATUS":"ENABLED","OWNER":"TFREEMAN3","CONSTRAINT_TYPE":"P","CONSTRAINT_NAME":"PK_TABLE_6"}
 */
@implementation EDJConstraint

-(id)initWithDictionary:(NSDictionary *)dic{
    self=[super init];
    self.constraintDetails = [[NSDictionary alloc] initWithDictionary:dic];
    return self;
}

-(NSString *)tableName{
    return [self.constraintDetails objectForKey:@"TABLE_NAME"];
}

-(NSString *)constraintType{
    return [self.constraintDetails objectForKey:@"CONSTRAINT_TYPE"];
}
-(NSString *)columnName{
    return [self.constraintDetails objectForKey:@"COLUMN_NAME"];
}
-(NSString *)constraintName{
    return [self.constraintDetails objectForKey:@"CONSTRAINT_NAME"];
}
-(BOOL)enabled{
    return [@"ENABLED" isEqualToString:[self.constraintDetails objectForKey:@"STATUS"]];
}
@end
