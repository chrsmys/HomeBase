//
//  EDJColumn.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/11/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EDJColumn : NSObject

-(id)initWithName:(NSString *)_name withType:(NSString *)_type;
-(id)initWithDictionary:(NSDictionary *)dictionary;
-(NSString *)formattedType;
-(NSString *)formattedSize;
@property(nonatomic, strong, readonly) NSString *name;
@property(nonatomic, strong, readonly) NSString *type;
@property(nonatomic, strong, readonly) NSString *length;
@property(nonatomic, strong, readonly) NSString *precision;
@property(nonatomic, strong, readonly) NSString *scale;

@end
