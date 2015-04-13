//
//  EDJTable.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/11/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDJTable : NSObject{
    NSMutableArray *columns;
    NSString *name;
}
-(instancetype)initWithTableData:(NSDictionary *)table;
-(NSString *)getName;
-(NSAttributedString *)getPreviewOfColumns:(int)columnAmount;
-(NSAttributedString *)getAllColumnsToString;
-(NSString *)getForeignKeyText;
-(NSArray *)getColumns;
-(void)removeColumnWithIndex:(int)colIndex;
-(BOOL)isPrimaryKey:(NSString *)columnName;
@property (nonatomic, retain) NSArray *foriegnKeys;
@property (nonatomic, retain) NSArray *primaryKeys;
@property (nonatomic, retain) NSMutableArray *triggers;
@property (nonatomic, retain) NSMutableArray *constraints;

@end
