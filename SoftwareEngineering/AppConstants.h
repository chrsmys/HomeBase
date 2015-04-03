//
//  AppConstants.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/27/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConstants : NSObject
extern NSString* const FORIEGN_KEY_DELETE_RULE;
extern NSString* const FORIEGN_KEY_COLUMN_NAME;
extern NSString* const FORIEGN_KEY_CONSTRAINT_NAME;
extern NSString* const FORIEGN_KEY_REFERENCE_TABLE;
extern NSString* const FORIEGN_KEY_REFERENCE_COLUMN;
extern NSString* const FORIEGN_KEY_DEFERRABLE;
extern NSString* const FORIEGN_KEY_DEFERRED;


extern NSString* const TABLE_TRIGGERS;

extern NSString* const TRIGGER_NAME;
extern NSString* const TRIGGER_TYPE;
extern NSString* const TRIGGERING_EVENT;
extern NSString* const TRIGGER_STATUS;
extern NSString* const TRIGGER_STATUS_ACTIVE;
extern NSString* const TRIGGER_STATUS_INACTIVE;
extern NSString* const TRIGGER_BODY;

extern NSString* const COLUMN_NAME;
extern NSString* const COLUMN_DATA_TYPE;
extern NSString* const COLUMN_DATA_LENGTH;
extern NSString* const COLUMN_DATA_PRECISION;
extern NSString* const COLUMN_DATA_SCALE;

@end
