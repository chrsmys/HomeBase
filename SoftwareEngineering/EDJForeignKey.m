//
//  EDJForeignKey.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/4/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "EDJForeignKey.h"
#import "AppConstants.h"

@implementation EDJForeignKey
@synthesize deleteRule=_deleteRule;
@synthesize columnName=_columnName;
@synthesize constraintName=_constraintName;
@synthesize referenceTable=_referenceTable;
@synthesize referenceColumn=_referenceColumn;
@synthesize deferrable=_deferrable;
@synthesize deffered=_deffered;

-(id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    
    _deleteRule = [dic objectForKey:FORIEGN_KEY_DELETE_RULE];
    _columnName = [dic objectForKey:FORIEGN_KEY_COLUMN_NAME];
    _constraintName = [dic objectForKey:FORIEGN_KEY_CONSTRAINT_NAME];
    _referenceTable= [dic objectForKey:FORIEGN_KEY_REFERENCE_TABLE];
    _referenceColumn= [dic objectForKey:FORIEGN_KEY_REFERENCE_COLUMN];
    _deferrable= [dic objectForKey:FORIEGN_KEY_DEFERRABLE];
    _deffered = [dic objectForKey:FORIEGN_KEY_DEFERRED];
    
    return self;
}

-(NSString *)previewString{
    return [NSString stringWithFormat:@"%@ %@ %@", self.constraintName, self.referenceTable, self.referenceColumn];
}
@end
