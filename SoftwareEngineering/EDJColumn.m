//
//  EDJColumn.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/11/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import "EDJColumn.h"
#import "AppConstants.h"
@implementation EDJColumn

@synthesize name=_name;
@synthesize type=_type;
-(id)initWithName:(NSString *)name withType:(NSString *)type{
    if(self=[super init]){
        _name=name;
        _type=type;
    
    }
    return self;
}
-(id)initWithDictionary:(NSDictionary *)dictionary{
    if(self=[super init]){
        _name = [dictionary objectForKey:COLUMN_NAME];
        _type = [dictionary objectForKey:COLUMN_DATA_TYPE];
        _length = [dictionary objectForKey:COLUMN_DATA_LENGTH];
        _precision = [dictionary objectForKey:COLUMN_DATA_PRECISION];
        _scale = [dictionary objectForKey:COLUMN_DATA_SCALE];
        
    }
    return self;
}
-(NSString *)formattedType{
    NSMutableString *typeString=[NSMutableString stringWithFormat:@"%@(",_type];
    
    if(_precision != nil && _scale != nil){
      [typeString appendFormat:@"%@,%@",_precision,_scale];
    }else{
      [typeString appendFormat:@"%@",_length];
    }
    [typeString appendString:@")"];
    
    return typeString;
}

-(NSString *)formattedSize{
    NSMutableString *typeString=[NSMutableString stringWithFormat:@""];
    if(_precision != nil && _scale != nil){
        [typeString appendFormat:@"%@,%@",_precision,_scale];
    }else{
        [typeString appendFormat:@"%@",_length];
    }
    return typeString;
}

@end
