//
//  EDJTable.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/11/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import "EDJTable.h"
#import "EDJColumn.h"
#import "EDJForeignKey.h"
#import "NSAttributedString+Constructors.h"
@implementation EDJTable

-(instancetype)initWithTableData:(NSDictionary *)table{
    if(self=[super init]){

        self.foriegnKeys=[NSArray arrayWithArray:[table objectForKey:@"TABLE_FOREIGN_KEY"]];
        self.primaryKeys=[NSArray arrayWithArray:[table objectForKey:@"TABLE_PRIMARY_KEY"]];
        name=[table objectForKey:@"TABLE_NAME"];
        NSArray *col=[table objectForKey:@"TABLE_COLS"];
        
        columns=[[NSMutableArray alloc] init];
        for(int i=0; i<[col count]; i++){
            EDJColumn *cols=[[EDJColumn alloc] initWithName:((NSString *)[[col objectAtIndex:i] objectForKey:@"COLUMN_NAME"] )withType:@""];
            [columns addObject:cols];
        }
        
    }
    return self;
}

-(NSAttributedString *)getPreviewOfColumns:(int)columnAmount{
    NSString *columnPreview=[[NSString alloc] init];
    for (int i=0; i<columnAmount && i<columns.count; i++) {
        EDJColumn *col=[columns objectAtIndex:i];
        NSString *foriegn = @"";
        
        columnPreview =[NSString stringWithFormat:@"%@%@%@%@", columnPreview, (i == 0 ? @"" : @"\n") , col.name, foriegn];
        
    }
    if(columnAmount<columns.count){
         columnPreview=[NSString stringWithFormat:@"%@\n...", columnPreview];
    }
    NSAttributedString *finalString = [[NSAttributedString alloc] initWithString:columnPreview];
    for (int i = 0; i<[self.primaryKeys count]; i++) {
        NSRange range = [[NSString stringWithFormat:@"%@", columnPreview] rangeOfString:[self.primaryKeys objectAtIndex:i]];
        if(range.location!=NSNotFound){
            finalString = [NSAttributedString returnNSAttributedStringWithAttributedString:finalString range:range WithColour:[UIColor blackColor] WithUnderLine:true];
        }
    }
    return finalString;
}

-(NSAttributedString *)getAllColumnsToString{
    return [self getPreviewOfColumns:[columns count]];
}
-(NSString *)getName{
    return name;
}
-(NSString *)getForeignKeyText{
    NSString *foreignKeys = @"";
    for (int i=0; i<[self.foriegnKeys count]; i++) {
        EDJForeignKey *key =[[EDJForeignKey alloc] initWithDic:[self.foriegnKeys objectAtIndex:i]];
        foreignKeys = [NSString stringWithFormat:@"%@%@%@",foreignKeys, i==0 ? @"" : @"\n", [key previewString]];
        
    }
    return foreignKeys;
}
-(BOOL)isEqual:(id)object{
    if ([object isKindOfClass:[EDJTable class]]) {
        EDJTable *table = (EDJTable *)object;
        object = [table getName];
    }
    if([object isKindOfClass:[NSString class]]){
        NSString *tableName = (NSString *) object;
        if ([tableName isEqualToString:[self getName]]) {
            return true;
        }
    }
    return false;
}

-(BOOL)isPrimaryKey:(NSString *)columnName{
    return [[self primaryKeys] containsObject:columnName];
}

-(BOOL)isForeignKey:(NSString *)columnName{
    return [[self primaryKeys] containsObject:columnName];
}

-(NSUInteger)hash{
    return [[self getName] hash];
}
-(NSArray *)getColumns{
    return columns;
}

@end
