//
//  EDJConstraint.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/6/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {"TABLE_NAME":"TEST_TABLE_6","COLUMN_NAME":"COL_1","POSITION":"1","STATUS":"ENABLED","OWNER":"TFREEMAN3","CONSTRAINT_TYPE":"P","CONSTRAINT_NAME":"PK_TABLE_6"}
 */
@interface EDJConstraint : NSObject
@property(nonatomic) NSString *constraintName;
@property(nonatomic) NSString *constraintType;
@property(nonatomic) NSString *owner;
@property(nonatomic) BOOL enabled;
@property(nonatomic) NSString *columnName;
@property(nonatomic) NSString *tableName;

-(id)initWithDictionary:(NSDictionary *)dic;

@end
