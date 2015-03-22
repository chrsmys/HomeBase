//
//  EDJConnection.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/11/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import "EDJConnection.h"
#import "EDJTable.h"
@implementation EDJConnection
@synthesize delegate;

-(instancetype)init{
    if(self=[super init]){
        conData=[[NSMutableData alloc] init];
    }
    return self;
}

-(void)getTablesForUserWithUsername:(NSString *)username withPassword:(NSString *)passwor withConnectionString:(NSString *)con{
    connection=[[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://php.radford.edu/~tfreeman3/Homebase/api/user_schema?user-name=%@&password=%@&connection-string=%@",username,passwor, con]]] delegate:self];
    [connection start];
    NSLog(@"called");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *respon=[[NSString alloc] initWithData:conData encoding:NSUTF8StringEncoding];
   // NSLog(@"%@",respon);
    NSError *error = nil;
    id object = [NSJSONSerialization
                 JSONObjectWithData:[respon dataUsingEncoding:NSUTF8StringEncoding]
                 options:0
                 error:&error];
    
    if(error) { NSLog(@"error %@", error); }
    NSLog(@"response %@", respon);
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
            [tableObjects addObject:tab];
        }
        [delegate connectionReturnedTableList:tableObjects];
    }
    
}


-(void)refreshSchema{
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [conData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{

}
@end
