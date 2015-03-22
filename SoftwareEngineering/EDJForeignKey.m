//
//  EDJForeignKey.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/4/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "EDJForeignKey.h"

@implementation EDJForeignKey
-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    self.deleteRule = [dic objectForKey:@"DELETE_RULE"];
    self.columnName = [dic objectForKey:@"COLUMN_NAME"];
    self.constraintName = [dic objectForKey:@"CONSTRAINT_NAME"];
    self.referenceTable= [dic objectForKey:@"REFERENCE_TABLE"];
    self.referenceColumn= [dic objectForKey:@"REFERENCE_COLUMN"];
    self.deferrable= [dic objectForKey:@"DEFERRABLE"];
    self.deffered = [dic objectForKey:@"DEFERRED"];
    return self;
}
-(NSString *)previewString{
    return [NSString stringWithFormat:@"%@ %@ %@", self.constraintName, self.referenceTable, self.referenceColumn];
}
@end
