//
//  ConstraintsInfoViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/27/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "ConstraintsInfoViewController.h"
#import "EDJTableServices.h"
@interface ConstraintsInfoViewController ()

@end

@implementation ConstraintsInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated
{
    [self.activityIndicator startAnimating];
    [[EDJTableServices sharedInstance] getConstraintInfoForConstraint:[self.constraint constraintName] tableName:self.constraint.tableName withCompletion:^(NSString* complete) {
       
        id object = [NSJSONSerialization
                     JSONObjectWithData:[complete dataUsingEncoding:NSUTF8StringEncoding]
                     options:0
                     error:nil];
       
        if ([object isKindOfClass:[NSArray class]]) {
            NSLog(@"");
        }
        
        if ([object isKindOfClass:[NSMutableDictionary class]]) {
            NSMutableDictionary* file = (NSMutableDictionary*)object;
            
            NSMutableArray *constraintsArray = [[NSMutableArray alloc] initWithArray:[file objectForKey:@"TABLE_CONSTRAINTS"]];
            
            NSDictionary *dictionary = [self merge:constraintsArray];
            
            
            
            NSString *parseData = [self parseData:dictionary];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                self.constraintInfoTextField.text=parseData;
                [self.activityIndicator stopAnimating];
                self.title = [dictionary objectForKey:@"CONSTRAINT_NAME"];

            }];
            
        }

    } withError:^(NSString* error){

    }];
    self.constraintInfoTextField.editable=false;
}

- (NSDictionary*)merge:(NSArray*)array
{
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    if ([array count] == 0) {
        return dictionary;
    }
    NSString* constraintType = [[array firstObject] objectForKey:@"CONSTRAINT_TYPE"];
    NSString* constraintName = [[array firstObject] objectForKey:@"CONSTRAINT_NAME"];
    NSString* tableName = [[array firstObject] objectForKey:@"TABLE_NAME"];
    NSString* deferrable = [[array firstObject] objectForKey:@"DEFERRABLE"];
    NSString* deferred = [[array firstObject] objectForKey:@"DEFERRED"];
    NSString* status = [[array firstObject] objectForKey:@"STATUS"];

    [dictionary setObject:constraintType forKey:@"CONSTRAINT_TYPE"];
    [dictionary setObject:constraintName forKey:@"CONSTRAINT_NAME"];
    [dictionary setObject:tableName forKey:@"TABLE_NAME"];
    [dictionary setObject:deferrable forKey:@"DEFERRABLE"];
    [dictionary setObject:deferred forKey:@"DEFERRED"];
    [dictionary setObject:status forKey:@"STATUS"];

    if ([constraintType isEqualToString:@"R"]) { //Foreign
        NSString* referenceTable = [[array firstObject] objectForKey:@"REFERENCE_TABLE"];
        NSString* deleteRule = [[array firstObject] objectForKey:@"DELETE_RULE"];
        [dictionary setObject:deleteRule forKey:@"DELETE_RULE"];
        [dictionary setObject:referenceTable forKey:@"REFERENCE_TABLE"];
        NSMutableArray* columnAssociations = [[NSMutableArray alloc] init];
        for (NSDictionary* assoc in array) {
            NSString* columnName = [assoc objectForKey:@"COLUMN_NAME"];
            NSString* refColumnName = [assoc objectForKey:@"REFERENCE_COLUMN"];

            NSDictionary* columnAssoc = @{
                @"COLUMN_NAME" : columnName,
                @"REFERNCE_COLUMN" : refColumnName
            };
            [columnAssociations addObject:columnAssoc];
        }
        [dictionary setObject:columnAssociations forKey:@"Associated_Cols"];
    }
    else if ([constraintType isEqualToString:@"U"] || [constraintType isEqualToString:@"P"]) { //unique
        NSMutableArray* columnNames = [[NSMutableArray alloc] init];
        for (NSDictionary* assoc in array) {
            [columnNames addObject:[assoc objectForKey:@"COLUMN_NAME"]];
        }
        [dictionary setObject:columnNames forKey:@"Column_Names"];
    }
    else if ([constraintType isEqualToString:@"C"]) { //check
        [dictionary setObject:[[array firstObject] objectForKey:@"SEARCH_CONDITION"] forKey:@"SEARCH_CONDITION"];
    }

    return dictionary;
}

- (NSString*)parseData:(NSDictionary*)dictionary
{

    NSString* constraintName = [dictionary objectForKey:@"CONSTRAINT_NAME"];
    NSString* constraintType = [NSString stringWithFormat:@"%@", [dictionary objectForKey:@"CONSTRAINT_TYPE"]];
    NSString* tableName = [NSString stringWithFormat:@"Table Name: %@", [dictionary objectForKey:@"TABLE_NAME"]];

    NSString* middleText = @"";

    if ([constraintType isEqualToString:@"R"]) { //Foreign
        NSString* refTableName = [dictionary objectForKey:@"REFERENCE_TABLE"];
        tableName = [NSString stringWithFormat:@"%@ -> %@", tableName, refTableName];
        middleText = @"\nRows\n---------------------------------\n";
        for (NSDictionary* cols in [dictionary objectForKey:@"Associated_Cols"]) {
            NSString* colsRef = [NSString stringWithFormat:@"%@ -> %@", [cols objectForKey:@"COLUMN_NAME"], [cols objectForKey:@"REFERNCE_COLUMN"]];
            middleText = [NSString stringWithFormat:@"%@%@\n", middleText, colsRef];
            constraintType = @"Foreign Key";
        }
        middleText = [NSString stringWithFormat:@"%@---------------------------------\n",middleText];
        NSString* deleteRule = [NSString stringWithFormat:@"Delete Rule %@", [dictionary objectForKey:@"DELETE_RULE"]];
        middleText = [NSString stringWithFormat:@"%@%@", middleText, deleteRule];
    }
    else if ([constraintType isEqualToString:@"U"] || [constraintType isEqualToString:@"P"]) { //unique
        middleText = @"\nColumns\n---------------------------------\n";
        for (NSString* cols in [dictionary objectForKey:@"Column_Names"]) {
            middleText = [NSString stringWithFormat:@"%@%@\n", middleText, cols];
        }
        middleText = [NSString stringWithFormat:@"%@---------------------------------\n",middleText];
        constraintType = [constraintType isEqualToString:@"U"] ? @"Unique" : @"Primary Key";
    }
    else if ([constraintType isEqualToString:@"C"]) { //check
        middleText = [NSString stringWithFormat:@"Search Condition: %@", [dictionary objectForKey:@"SEARCH_CONDITION"]];
        constraintType = @"Check";
    }
    constraintType = [NSString stringWithFormat:@"Constraint Type: %@", constraintType];
    NSString* deferable = [NSString stringWithFormat:@"Deferrable: %@", [dictionary objectForKey:@"DEFERRABLE"]];
    NSString* deferred = [NSString stringWithFormat:@"Deferred: %@", [dictionary objectForKey:@"DEFERRED"]];
    NSString* status = [NSString stringWithFormat:@"Status: %@", [dictionary objectForKey:@"STATUS"]];
    
    
    return [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@", constraintType, tableName, middleText, deferable, deferred, status];
}

- (NSString*)parseFK:(NSDictionary*)dictionary
{
    return @"";
}
- (NSString*)parsePK:(NSDictionary*)dictionary
{
    return @"";
}
- (NSString*)parseUnique:(NSDictionary*)dictionary
{
    return @"";
}
- (NSString*)parseCheck:(NSDictionary*)dictionary
{
    return @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)doneButtonePressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
