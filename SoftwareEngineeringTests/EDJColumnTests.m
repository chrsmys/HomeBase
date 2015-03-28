//
//  EDJColumnTests.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/27/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "EDJColumn.h"
@interface EDJColumnTests : XCTestCase

@end

@implementation EDJColumnTests

- (void)columnTest{
    EDJColumn *column = [[EDJColumn alloc] initWithName:@"Column" withType:@"VARCHAR2"];
    XCTAssert([[column name] isEqualToString:@"Column"], @"Pass");
    XCTAssert([[column type] isEqualToString:@"VARCHAR2"], @"Pass");
}

@end
