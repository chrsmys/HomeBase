//
//  EDJForeignKeyTests.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/27/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "EDJForeignKey.h"
#import "AppConstants.h"
@interface EDJForeignKeyTests : XCTestCase

@end

@implementation EDJForeignKeyTests

- (void)testForeignKeys {
    EDJForeignKey *foreignKey = [[EDJForeignKey alloc] initWithDic:@{FORIEGN_KEY_DELETE_RULE : @"DELETE_RULE", FORIEGN_KEY_COLUMN_NAME : @"COLUMN_NAME", FORIEGN_KEY_CONSTRAINT_NAME : @"CONSTRAINT_NAME", FORIEGN_KEY_REFERENCE_COLUMN : @"REF_COLUMN", FORIEGN_KEY_DEFERRABLE : @"DEFERABLE", FORIEGN_KEY_DEFERRED : @"DEFERRED"}];
    XCTAssert([[foreignKey deleteRule] isEqualToString:@"DELETE_RULE"],@"PASS");
    XCTAssert([[foreignKey columnName] isEqualToString:@"COLUMN_NAME"],@"PASS");
    XCTAssert([[foreignKey constraintName] isEqualToString:@"CONSTRAINT_NAME"],@"PASS");
    XCTAssert([[foreignKey referenceColumn] isEqualToString:@"REF_COLUMN"],@"PASS");
    XCTAssert([[foreignKey deferrable] isEqualToString:@"DEFERABLE"],@"PASS");
    XCTAssert([[foreignKey deffered] isEqualToString:@"DEFERRED"],@"PASS");
    
}

@end
