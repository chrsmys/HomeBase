//
//  EDJTableServices.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/3/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EDJTableCreationRequest;

@protocol TableServicesDelegate
- (void)tableSchemaUpdated;
- (void)didRecieveError;
- (void)failedToDropTable:(NSString*)tableName withError:(NSDictionary*)error;
@end

@interface EDJTableServices : NSObject {
}
@property (nonatomic, retain) NSMutableArray* tables;
@property (nonatomic, weak) id<TableServicesDelegate> delegate;
- (void)dropTable:(NSString*)table;
- (void)refreshSchema;
+ (EDJTableServices*)sharedInstance;
- (void)addTableWithRequest:(EDJTableCreationRequest*)tRequest withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod;
- (void)dropColumn:(NSString*)column withTableName:(NSString*)table withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod;
- (void)addColumnWithTableName:(NSString*)tableName columnName:(NSString*)columnName columnType:(NSString*)columnType columnLength:(int)length notNull:(BOOL)notNull isUnique:(BOOL)isUnique withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod;
- (void)changeTableName:(NSString*)oldName newName:(NSString*)newName withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod;
- (void)editColumnWithTableName:(NSString*)tableName columnName:(NSString*)columnName columnType:(NSString*)columnType columnLength:(NSString*)length withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod;
- (void)renameColumninTable:(NSString*)tablename oldColumnName:(NSString*)oldColumn newColumnName:(NSString*)newColumnName withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod;
- (void)removeConstraint:(NSString*)constraintName InTable:(NSString*)tablename withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod;
@end
