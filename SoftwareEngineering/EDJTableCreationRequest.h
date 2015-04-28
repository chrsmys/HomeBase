//
//  EDJTableCreationRequest.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/16/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDJTableCreationRequest : NSObject
@property (nonatomic) NSString* tableName;
@property (nonatomic) NSMutableArray* columns;
@property (nonatomic) NSMutableDictionary* primaryKey;
@property (nonatomic) NSMutableArray* foriegnKeys;
@property (nonatomic) NSUInteger expectedColumnCount;

@property (nonatomic) NSMutableArray* listOfPossibleFKNames;
@property (nonatomic) NSMutableArray* listOfPrimaryKeys;

- (void)addColumnWithName:(NSString*)columnName type:(NSString*)type size:(int)size notNull:(BOOL)notNull unique:(BOOL)unique;
- (void)addPrimaryKeyWithConstraintName:(NSString*)constraintName withColumns:(NSArray*)columns;
- (void)addForiegnKeyWithConstraintName:(NSString*)constraintName tableColumn:(NSString*)tColumn refTable:(NSString*)referencingTable refCol:(NSString*)referencingColumn deferable:(BOOL)deferable;
- (NSString*)getNetworkJSONRequest;
-(NSArray *)getColumnList;

@end
