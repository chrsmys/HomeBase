//
//  EDJSingletonExample.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/14/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

@interface EDJSingletonExample : NSObject

/**
 * gets singleton object.
 * @return singleton
 */
+ (EDJSingletonExample*)sharedInstance;
@property(nonatomic, strong) NSMutableArray *array;
@end
