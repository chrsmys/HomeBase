//
//  EDJTableServices.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/3/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EDJTableCreationRequest;
@class EDJTable;
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
- (EDJTable*)getTableObjectWithName:(NSString*)tableName;
- (void)addTableWithRequest:(EDJTableCreationRequest*)tRequest withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod;
- (void)dropColumn:(NSString*)column withTableName:(NSString*)table withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod;
- (void)addColumnWithTableName:(NSString*)tableName columnName:(NSString*)columnName columnType:(NSString*)columnType columnLength:(int)length notNull:(BOOL)notNull isUnique:(BOOL)isUnique withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod;
- (void)changeTableName:(NSString*)oldName newName:(NSString*)newName withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod;
- (void)editColumnWithTableName:(NSString*)tableName columnName:(NSString*)columnName columnType:(NSString*)columnType columnLength:(NSString*)length withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod;
- (void)renameColumninTable:(NSString*)tablename oldColumnName:(NSString*)oldColumn newColumnName:(NSString*)newColumnName withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod;
- (void)removeConstraint:(NSString*)constraintName InTable:(NSString*)tablename withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod;
-(void)addUniqueKeyWithName:(NSString *)name table:(NSString *)tableName columnsInKey:(NSArray *)columnsInKey withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod;
-(void)addCheckConstraintWithName:(NSString *)name table:(NSString *)tableName condition:(NSString *)condition withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod;
-(void)addNotNullConstraintWithName:(NSString *)name table:(NSString *)tableName columnName:(NSString *)columnName withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod;
- (void)addFKConstraintWithName:(NSString*)name table:(NSString*)tableName cons: (NSString *)cons withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod;
- (void)addPKConstraintWithName:(NSString*)name table:(NSString*)tableName cols: (NSArray *)cols withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod;


-(void)reloadTableWithName:(NSString *)name withCompletion:(void (^)(EDJTable *table))completion withError:(void (^)(NSString* error))errorMethod;

-(void)loginValidator:(NSString *)username password:(NSString *)password connectionString:(NSString *)connectionString withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod;

-(void)getConstraintInfoForConstraint:(NSString *)constraintName tableName:(NSString *)tablename withCompletion:(void (^)(NSString *info))completion withError:(void (^)(NSString* error))errorMethod;

@end
