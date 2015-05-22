//
//  EDJTableCreationRequest.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/16/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "EDJTableCreationRequest.h"

@implementation EDJTableCreationRequest
- (instancetype)init
{
    self = [super init];
    self.columns = [[NSMutableArray alloc] init];
    self.primaryKey = [[NSMutableDictionary alloc] init];
    self.foriegnKeys = [[NSMutableArray alloc] init];
    self.listOfPrimaryKeys = [[NSMutableArray alloc] init];
    self.listOfPossibleFKNames = [[NSMutableArray alloc] init];
    return self;
}
- (void)addColumnWithName:(NSString*)columnName type:(NSString*)type size:(int)size notNull:(BOOL)notNull unique:(BOOL)unique
{

    NSMutableDictionary* column = [NSMutableDictionary dictionaryWithDictionary:@{ @"name" : columnName,
        @"type" : type,
        @"notNull" : [NSNumber numberWithBool:notNull],
        @"unique" : [NSNumber numberWithBool:unique] }];
    if (size > 0) {
        [column setObject:[NSNumber numberWithInt:size] forKey:@"size"];
    }
    [self.columns addObject:column];
}

- (void)addPrimaryKeyWithConstraintName:(NSString*)constraintName withColumns:(NSArray*)columns
{
    NSMutableDictionary* primaryKeyDictionary = [NSMutableDictionary dictionaryWithDictionary:@{ @"constraintName" : constraintName,
        @"cols" : columns }];
    [self setPrimaryKey:primaryKeyDictionary];
}

- (void)addForiegnKeyWithConstraintName:(NSString*)constraintName tableColumn:(NSString*)tColumn refTable:(NSString*)referencingTable refCol:(NSString*)referencingColumn deferable:(BOOL)deferable
{
    NSDictionary* foriegnDictionary = @{ @"constraintName" : constraintName,
        @"tableCol" : tColumn,
        @"refTable" : referencingTable,
        @"refCol" : referencingColumn,
        @"deferrable" : [NSNumber numberWithBool:deferable] };
    [self.foriegnKeys addObject:foriegnDictionary];
}

- (NSString*)getNetworkJSONRequest
{
    NSMutableDictionary* finalJSON = [[NSMutableDictionary alloc] init];
    [finalJSON setObject:self.tableName forKey:@"name"];
    [finalJSON setObject:self.columns forKey:@"cols"];
    [finalJSON setObject:self.foriegnKeys forKey:@"foreignKey"];
    if (self.primaryKey.count >0) {
        [finalJSON setObject:self.primaryKey forKey:@"primaryKey"];
    }
    return [self dictionaryToJSON:finalJSON];
}

-(NSArray *)getColumnList{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in self.columns) {
        [array addObject:[dictionary objectForKey:@"name"]];
    }
    return array;
}

- (NSString*)dictionaryToJSON:(NSDictionary*)dictionary
{
    NSError* error;
    NSData* data = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    return [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
}
@end
