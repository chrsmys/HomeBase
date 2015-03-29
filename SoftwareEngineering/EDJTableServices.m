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
            NSLog(@"Error Refreshing Scheme %@", error);
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
    if(error) { NSLog(@"error parsing JSON %@", error); }
    else if([object isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *results = object;
        NSArray *tables=[results objectForKey:@"USER_SCHEMA"];
        NSMutableArray *tableObjects=[[NSMutableArray alloc] init];
        for(int i=0; i<[tables count]; i++){
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
