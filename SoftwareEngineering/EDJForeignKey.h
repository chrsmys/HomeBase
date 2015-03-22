//
//  EDJForeignKey.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/4/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDJForeignKey : NSObject
@property(nonatomic, retain) NSString *deleteRule;
@property(nonatomic,retain) NSString *columnName;
@property(nonatomic,retain) NSString *constraintName;
@property(nonatomic,retain) NSString *referenceTable;
@property(nonatomic,retain) NSString *referenceColumn;
@property(nonatomic,retain) NSString *deferrable;
@property(nonatomic,retain) NSString *deffered;
-(NSString *)previewString;
-(id)initWithDic:(NSDictionary *)dic;
@end
