//
//  EDJColumn.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/11/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDJColumn : NSObject{
    NSString *type;
    NSInteger *columnIndex;
}
-(id)initWithName:(NSString *)_name withType:(NSString *)_type;
@property(nonatomic, strong) NSString *name;
@end
