//
//  EDJTableTests.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/22/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "EDJTable.h"
#import "EDJColumn.h"
@interface EDJTableTests : XCTestCase

@end

@implementation EDJTableTests
const NSString *table1Data = @"{\"TABLE_NAME\":\"TEST\",\"TABLE_COLS\":[{\"COLUMN_NAME\":\"T1\"},{\"COLUMN_NAME\":\"T2\"}],\"TABLE_PRIMARY_KEY\":[\"T1\"],\"TABLE_FOREIGN_KEY\":[],\"TABLE_TRIGGERS\":[]}";
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/*
    The point of this test is to verify the creation of tables
    is accurate.
 */
- (void)testTable1{
    NSMutableDictionary *tableData=[NSJSONSerialization
                                                 JSONObjectWithData:[table1Data dataUsingEncoding:NSUTF8StringEncoding]
                                                 options:0
                                                 error:nil];
    EDJTable *table = [[EDJTable alloc] initWithTableData:tableData];
    XCTAssert([[table getName] isEqualToString:@"TEST"], @"Fail");
    XCTAssert([[table getColumns] count]==2);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
