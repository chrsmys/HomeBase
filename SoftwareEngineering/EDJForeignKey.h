//
//  EDJForeignKey.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/4/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDJForeignKey : NSObject
@property(nonatomic, retain, readonly) NSString *deleteRule;
@property(nonatomic,retain, readonly) NSString *columnName;
@property(nonatomic,retain, readonly) NSString *constraintName;
@property(nonatomic,retain, readonly) NSString *referenceTable;
@property(nonatomic,retain, readonly) NSString *referenceColumn;
@property(nonatomic,retain, readonly) NSString *deferrable;
@property(nonatomic,retain, readonly) NSString *deffered;
-(NSString *)previewString;
-(id)initWithDic:(NSDictionary *)dic;
@end
