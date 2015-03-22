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
-(void)tableSchemaUpdated;
-(void)didRecieveError;
-(void)failedToDropTable:(NSString *)tableName withError:(NSDictionary *)error;
@end

@interface EDJTableServices : NSObject{
    
}
@property(nonatomic, retain)NSMutableArray *tables;
@property(nonatomic, weak) id<TableServicesDelegate> delegate;
- (void)dropTable:(NSString *)table;
-(void)refreshSchema;
+ (EDJTableServices *)sharedInstance;
-(void)createTableWithName:(NSString *)name withColumns:(NSArray *)columns withForeignKeys:(NSArray *)fks primaryKeys:(NSDictionary *)pk;
-(void)addTableWithRequest:(EDJTableCreationRequest *)tRequest withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString *error))errorMethod;
@end
