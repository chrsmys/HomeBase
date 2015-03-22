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
@synthesize tables=_tables;

static EDJTableServices *sharedInstance;


-(id)init{
    self=[super init];
    _tables=[[NSMutableArray alloc] init];
    return self;
}

-(void)dropTable:(NSString *)table{
    EDJTable *tableToRemove=[self getTableObjectWithName:table];
    int indexForRemovedTable;
    if(tableToRemove){
        indexForRemovedTable=[self.tables indexOfObject:tableToRemove];
        [self.tables removeObjectAtIndex:indexForRemovedTable];
        self.tables=_tables;
    }
    
    EDJUser *user =[EDJUser sharedInstance];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://php.radford.edu/~tfreeman3/Homebase/api/user_table_put_delete"]];
    request.HTTPBody = [[self createRequestWithDictionary:@{@"table-name": table, @"user-name" : [user getDBUsername], @"connection-string" : [user getConnectionString], @"password" : [user getDBPassword] }] dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    request.timeoutInterval=120;
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            id object = [NSJSONSerialization
                         JSONObjectWithData:data
                         options:0
                         error:&error];
            if ([object isKindOfClass:[NSArray class]]) {
                
            }else{
                NSLog(@"eroor %@", object);
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

-(void)refreshSchema{
    EDJUser *user =[EDJUser sharedInstance];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://php.radford.edu/~tfreeman3/Homebase/api/user_schema"]];
    request.HTTPBody = [[self createRequestWithDictionary:@{@"user-name" : [user getDBUsername], @"connection-string" : [user getConnectionString], @"password" : [user getDBPassword] }] dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            [self performSelectorOnMainThread:@selector(handleNewSchema:) withObject:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] waitUntilDone:false];
        }
        else{
            NSLog(@"Big erroe %@", error);
        }
    }];
    [task resume];
}
-(EDJTable *)getTableObjectWithName:(NSString *)tableName{
    for (int i=0; i<[_tables count]; i++) {
        EDJTable *table = [_tables objectAtIndex:i];
        if([[table getName] isEqualToString:tableName]){
            return table;
        }
    }
    return nil;
}
-(NSString *)createRequestWithDictionary:(NSDictionary *)values{
    NSString *request=@"";
    for(int i=0; i<[[values allKeys] count]; i++){
        NSString *key = [[values allKeys] objectAtIndex:i];
        NSString *value = [values objectForKey:key];
        
        request=[request stringByAppendingString:key];
        request=[request stringByAppendingString:@"="];
        request=[request stringByAppendingString:value];
        
        if(i+1<[[values allKeys] count]){
            request=[request stringByAppendingString:@"&"];
        }
    }
    return request;
}

-(void)handleNewSchema:(NSString *)response{
    [_tables removeAllObjects];
    NSError *error = nil;
    id object = [NSJSONSerialization
                 JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding]
                 options:0
                 error:&error];
    
    if(error) { NSLog(@"error %@", error); }
    NSLog(@"response %@", response);
    // the originating poster wants to deal with dictionaries;
    // assuming you do too then something like this is the first
    // validation step:
    if([object isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *results = object;
        // NSLog(@"There are 28 tables %d", [[results objectForKey:@"USER_SCHEMA"] count]);
        NSArray *tables=[results objectForKey:@"USER_SCHEMA"];
        NSMutableArray *tableObjects=[[NSMutableArray alloc] init];
        for(int i=0; i<[tables count]; i++){
            // NSLog(@"happened");
            EDJTable *tab=[[EDJTable alloc] initWithTableData:[tables objectAtIndex:i]];
            [_tables addObject:tab];
        }
    }
    [_delegate tableSchemaUpdated];
}
-(void)setTables:(NSMutableArray *)tables{
    _tables = tables;
    [_delegate tableSchemaUpdated];
}
-(NSMutableArray *)tables{
    return _tables;
}

/*
    Keys:
        name:string
        cols:array<Dictionary>
        primaryKey:
        foreignKey:
 */
-(void)createTableWithName:(NSString *)name withColumns:(NSArray *)columns withForeignKeys:(NSArray *)fks primaryKeys:(NSDictionary *)pk{
    NSMutableDictionary *finalJSON = [[NSMutableDictionary alloc] init];
    [finalJSON setObject:name forKey:@"name"];
    [finalJSON setObject:columns forKey:@"cols"];
    [finalJSON setObject:fks forKey:@"foreignKey"];
    [finalJSON setObject:pk forKey:@"primaryKey"];
    NSLog(@"dictionaryToJSON %@", [self dictionaryToJSON:finalJSON]);
    
}

-(NSString *)dictionaryToJSON:(NSDictionary *)dictionary{
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    return [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
}



-(void)addTableWithRequest:(EDJTableCreationRequest *)tRequest withCompletion:(void (^)(BOOL finished))completion withError:(void (^)(NSString *error))errorMethod {
    EDJUser *user =[EDJUser sharedInstance];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://php.radford.edu/~tfreeman3/Homebase/api/user_table"]];
    request.HTTPBody = [[self createRequestWithDictionary:@{@"user-name" : [user getDBUsername], @"connection-string" : [user getConnectionString], @"password" : [user getDBPassword], @"table_post" : [tRequest getNetworkJSONRequest] }] dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSLog(@"response %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            completion(true);
        }
        else{
            errorMethod(@"Error Connecting");
        }
    }];
    [task resume];
}



+ (EDJTableServices *)sharedInstance{
    if(!sharedInstance){
        sharedInstance=[[EDJTableServices alloc] init];
    }
    return sharedInstance;
}


@end
