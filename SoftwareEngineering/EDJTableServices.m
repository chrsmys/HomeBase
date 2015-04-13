//
//  EDJTableServices.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/3/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "EDJTableServices.h"
#import "EDJUser.h"
#import "EDJTable.h"
#import "EDJTableCreationRequest.h"
@implementation EDJTableServices
@synthesize tables = _tables;

static EDJTableServices* sharedInstance;

- (id)init
{
    self = [super init];
    _tables = [[NSMutableArray alloc] init];
    return self;
}

- (void)dropTable:(NSString*)table
{
    EDJTable* tableToRemove = [self getTableObjectWithName:table];
    int indexForRemovedTable;
    if (tableToRemove) {
        indexForRemovedTable = [self.tables indexOfObject:tableToRemove];
        [self.tables removeObjectAtIndex:indexForRemovedTable];
        self.tables = _tables;
    }

    EDJUser* user = [EDJUser sharedInstance];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://php.radford.edu/~tfreeman3/Homebase/api/user_table_put_delete"]];
    request.HTTPBody = [[self createRequestWithDictionary:@{ @"table-name" : table,
        @"user-name" : [user getDBUsername],
        @"connection-string" : [user getConnectionString],
        @"password" : [user getDBPassword] }] dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 120;
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
        if (!error) {
            id object = [NSJSONSerialization
                         JSONObjectWithData:data
                         options:0
                         error:&error];
            if ([object isKindOfClass:[NSArray class]]) {
                
            }else{
                NSDictionary *errorDictionary = [object objectForKey:@"error"];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(errorDictionary!=nil){
                    [_tables insertObject:tableToRemove atIndex:indexForRemovedTable];
                    self.tables=_tables;
                    [_delegate failedToDropTable:table withError:errorDictionary];
                }else{
                    
                }
            });
            }
        }
        else{
        }
    }];
    [task resume];
}

- (void)refreshSchema
{
    EDJUser* user = [EDJUser sharedInstance];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://php.radford.edu/~tfreeman3/Homebase/api/user_schema"]];
    request.HTTPBody = [[self createRequestWithDictionary:@{ @"user-name" : [user getDBUsername],
        @"connection-string" : [user getConnectionString],
        @"password" : [user getDBPassword] }] dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    //NSString *header = [self createRequestWithDictionary:@{@"user-name" : [user getDBUsername], @"connection-string" : [user getConnectionString], @"password" : [user getDBPassword] }];
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
        if (!error) {
            [self performSelectorOnMainThread:@selector(handleNewSchema:) withObject:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] waitUntilDone:false];
        }
        else{
            NSLog(@"Error Refreshing Scheme %@", error);
        }
    }];
    [task resume];
}
- (EDJTable*)getTableObjectWithName:(NSString*)tableName
{
    for (int i = 0; i < [_tables count]; i++) {
        EDJTable* table = [_tables objectAtIndex:i];
        if ([[table getName] isEqualToString:tableName]) {
            return table;
        }
    }
    return nil;
}
- (NSString*)createRequestWithDictionary:(NSDictionary*)values
{
    NSString* request = @"";
    for (int i = 0; i < [[values allKeys] count]; i++) {
        NSString* key = [[values allKeys] objectAtIndex:i];
        NSString* value = [NSString stringWithFormat:@"%@", [values objectForKey:key]];

        request = [request stringByAppendingString:key];
        request = [request stringByAppendingString:@"="];
        request = [request stringByAppendingString:value];

        if (i + 1 < [[values allKeys] count]) {
            request = [request stringByAppendingString:@"&"];
        }
    }
    return request;
}

- (void)handleNewSchema:(NSString*)response
{
    NSLog(@"%@", response);
    [_tables removeAllObjects];
    NSError* error = nil;
    id object = [NSJSONSerialization
        JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding]
                   options:0
                     error:&error];
    if (error) {
        NSLog(@"error parsing JSON %@", error);
    }
    else if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary* results = object;
        NSArray* tables = [results objectForKey:@"USER_SCHEMA"];
        for (int i = 0; i < [tables count]; i++) {
            EDJTable* tab = [[EDJTable alloc] initWithTableData:[tables objectAtIndex:i]];
            [_tables addObject:tab];
        }
    }
    [_delegate tableSchemaUpdated];
}
- (void)setTables:(NSMutableArray*)tables
{
    _tables = tables;
    [_delegate tableSchemaUpdated];
}
- (NSMutableArray*)tables
{
    return _tables;
}

- (NSString*)dictionaryToJSON:(NSDictionary*)dictionary
{
    NSError* error;
    NSData* data = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    return [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
}

- (void)addTableWithRequest:(EDJTableCreationRequest*)tRequest withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod
{
    EDJUser* user = [EDJUser sharedInstance];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://php.radford.edu/~tfreeman3/Homebase/api/user_table"]];
    request.HTTPBody = [[self createRequestWithDictionary:@{ @"user-name" : [user getDBUsername],
        @"connection-string" : [user getConnectionString],
        @"password" : [user getDBPassword],
        @"table_post" : [tRequest getNetworkJSONRequest] }] dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";

    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
        if (!error) {
            if([self isError:data]){
                errorMethod([[self getError:data] objectForKey:@"message"]);
                
            }else{
                completion(true);
            }
        }
        else{
            errorMethod(@"Error Connecting");
        }
    }];
    [task resume];
}

- (void)dropColumn:(NSString*)column withTableName:(NSString*)table withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod
{
    EDJUser* user = [EDJUser sharedInstance];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://php.radford.edu/~tfreeman3/Homebase/api/user_alter_table_column_put_delete"]];
    request.HTTPBody = [[self createRequestWithDictionary:@{ @"user-name" : [user getDBUsername],
        @"connection-string" : [user getConnectionString],
        @"password" : [user getDBPassword],
        @"table-name" : table,
        @"column-name" : column }] dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";

    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
        if (!error) {
            if([self isError:data]){
                errorMethod([[self getError:data] objectForKey:@"message"]);
                
            }else{
                completion(true);
            }
        }
        else{
            errorMethod(@"Error Connecting");
        }
    }];
    [task resume];
}

+ (EDJTableServices*)sharedInstance
{
    if (!sharedInstance) {
        sharedInstance = [[EDJTableServices alloc] init];
    }
    return sharedInstance;
}

- (void)addColumnWithTableName:(NSString*)tableName columnName:(NSString*)columnName columnType:(NSString*)columnType columnLength:(int)length notNull:(BOOL)notNull isUnique:(BOOL)isUnique withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod
{
    EDJUser* user = [EDJUser sharedInstance];
    NSMutableDictionary* requestDictionary = [[NSMutableDictionary alloc] initWithDictionary:@{ @"user-name" : [user getDBUsername],
        @"connection-string" : [user getConnectionString],
        @"password" : [user getDBPassword],
        @"table-name" : tableName,
        @"column-name" : columnName,
        @"column-type" : columnType }];

    if (length > 0) {
        [requestDictionary setObject:[NSNumber numberWithInt:length] forKey:@"column-size"];
    }
    else if ([[columnType lowercaseString] isEqualToString:@"varchar2"]) {
        errorMethod(@"Length can't be 0 or less");
        return;
    }
    if (notNull) {
        [requestDictionary setObject:@true forKey:@"not-null"];
    }
    if (isUnique) {
        [requestDictionary setObject:@true forKey:@"unique"];
    }

    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://php.radford.edu/~tfreeman3/Homebase/api/user_alter_table_column"]];
    request.HTTPBody = [[self createRequestWithDictionary:requestDictionary] dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";

    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
        if (!error) {
            if([self isError:data]){
                errorMethod([[self getError:data] objectForKey:@"message"]);
                
            }else{
                completion(true);
            }
        }
        else{
            errorMethod(@"Error Connecting");
        }
    }];
    [task resume];
}

- (void)editColumnWithTableName:(NSString*)tableName columnName:(NSString*)columnName columnType:(NSString*)columnType columnLength:(NSString*)length withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod
{
    EDJUser* user = [EDJUser sharedInstance];
    NSMutableDictionary* requestDictionary = [[NSMutableDictionary alloc] initWithDictionary:@{ @"user-name" : [user getDBUsername],
        @"connection-string" : [user getConnectionString],
        @"password" : [user getDBPassword],
        @"table-name" : tableName,
        @"column-name" : columnName,
        @"new-column-type" : columnType }];

    if (length > 0) {
        [requestDictionary setObject:length forKey:@"new-column-size"];
    }

    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://php.radford.edu/~tfreeman3/Homebase/api/user_alter_table_column_put_delete?%@", [self createRequestWithDictionary:requestDictionary]]]];
    request.HTTPMethod = @"GET";

    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
        if (!error) {
            NSString *request = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if([self isError:data]){
                errorMethod([[self getError:data] objectForKey:@"message"]);

            }else{
                completion(true);
            }
        }
        else{
            errorMethod(@"Error Connecting ");
        }
    }];
    [task resume];
}

- (void)changeTableName:(NSString*)oldName newName:(NSString*)newName withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod
{
    EDJUser* user = [EDJUser sharedInstance];
    NSMutableDictionary* requestDictionary = [[NSMutableDictionary alloc] initWithDictionary:@{ @"user-name" : [user getDBUsername],
        @"connection-string" : [user getConnectionString],
        @"password" : [user getDBPassword],
        @"table-name" : oldName,
        @"new-table-name" : newName }];

    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://php.radford.edu/~tfreeman3/Homebase/api/user_alter_table_name"]];
    request.HTTPBody = [[self createRequestWithDictionary:requestDictionary] dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";

    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
        if (!error) {
            if([self isError:data]){
                errorMethod([[self getError:data] objectForKey:@"message"]);
                
            }else{
                completion(true);
            }
        }
        else{
            errorMethod(@"Error Connecting");
        }
    }];
    [task resume];
}

- (void)renameColumninTable:(NSString*)tablename oldColumnName:(NSString*)oldColumn newColumnName:(NSString*)newColumnName withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod
{
    EDJUser* user = [EDJUser sharedInstance];
    NSMutableDictionary* requestDictionary = [[NSMutableDictionary alloc] initWithDictionary:@{ @"user-name" : [user getDBUsername],
        @"connection-string" : [user getConnectionString],
        @"password" : [user getDBPassword],
        @"table-name" : tablename,
        @"column-name" : oldColumn,
        @"new-column-name" : newColumnName }];

    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://php.radford.edu/~tfreeman3/Homebase/api/user_alter_column_name"]];
    request.HTTPBody = [[self createRequestWithDictionary:requestDictionary] dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";

    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
        if (!error) {
            if([self isError:data]){
                errorMethod([[self getError:data] objectForKey:@"message"]);
                
            }else{
                completion(true);
            }
        }
        else{
            errorMethod(@"Error Connecting");
        }
    }];
    [task resume];
}

- (void)removeConstraint:(NSString*)constraintName InTable:(NSString*)tablename withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString* error))errorMethod
{

    EDJUser* user = [EDJUser sharedInstance];
    NSMutableDictionary* requestDictionary = [[NSMutableDictionary alloc] initWithDictionary:@{ @"user-name" : [user getDBUsername],
        @"connection-string" : [user getConnectionString],
        @"password" : [user getDBPassword],
        @"table-name" : tablename,
        @"constraint-name" : constraintName }];

    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://php.radford.edu/~tfreeman3/Homebase/api/user_alter_table_constraint_put_delete"]];
    request.HTTPBody = [[self createRequestWithDictionary:requestDictionary] dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";

    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
        if (!error) {
            if([self isError:data]){
                errorMethod([[self getError:data] objectForKey:@"message"]);
                
            }else{
                completion(true);
            }
        }
        else{
            errorMethod(@"Error Connecting");
        }
    }];
    [task resume];
}

- (BOOL)isError:(NSData*)data
{
    id object = [NSJSONSerialization
        JSONObjectWithData:data
                   options:0
                     error:nil];
    if ([object isKindOfClass:[NSMutableDictionary class]]) {
        NSMutableDictionary* file = (NSMutableDictionary*)object;
        if ([file objectForKey:@"error"] != nil) {
            return true;
        }
        else {
            return false;
        }
    }
    else {
        return false;
    }
}

- (NSMutableDictionary*)getError:(NSData*)data
{
    id object = [NSJSONSerialization
        JSONObjectWithData:data
                   options:0
                     error:nil];
    if ([object isKindOfClass:[NSMutableDictionary class]]) {
        NSMutableDictionary* file = (NSMutableDictionary*)object;
        if ([file objectForKey:@"error"] != nil) {
            return [file objectForKey:@"error"];
        }
        else {
            return nil;
        }
    }
    else {
        return nil;
    }
}

@end
