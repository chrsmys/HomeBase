//
//  FKCreationViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/26/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "FKCreationViewController.h"
#import "EDJFKKeySelectionDataSource.h"
#import "EDJTableServices.h"
#import "EDJTableSubmissionViewController.h"
@interface FKCreationViewController ()
@property(nonatomic) EDJFKKeySelectionDataSource *dataSource;
@property(nonatomic) NSString *referencingTable;
@end

@implementation FKCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(referencingTableChanged:) name:@"ReferencingNameChaned" object:nil];
}
-(void)viewDidAppear:(BOOL)animated{
    self.dataSource = [[EDJFKKeySelectionDataSource alloc] initWithTable:self.table withColumnsInKey:@[self.actionColumn]];
    self.keyCreationTableView.dataSource = self.dataSource;
    self.keyCreationTableView.delegate = self.dataSource;
    [self.keyCreationTableView reloadData];
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(nextButtonPressed)];
    self.navigationItem.rightBarButtonItem = nextButton;

    self.title = [NSString stringWithFormat:@"%@: FK Constraint", [self.table getName]];
}

-(void)nextButtonPressed{
    if ([self.dataSource consObject]) {
        [self performSegueWithIdentifier:@"moveToSubmission" sender:self];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please select a referencing column for all columns 'in key'" delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)referencingTableButtonPressed:(id)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *nav = [story instantiateViewControllerWithIdentifier:@"TablesView"];
    
    EDJListTableTableViewController *content = [[nav viewControllers] firstObject];
    content.delegate = self;
    UIPopoverController *popController = [[UIPopoverController alloc] initWithContentViewController:nav];
    
    [popController presentPopoverFromRect:self.referencingTableButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)didSelectTableWithTableName:(NSString*)tableName
{
    [self.referencingTableButton setTitle:tableName forState:UIControlStateNormal];
    self.referencingTable = tableName;
    self.dataSource.referencingTable = tableName;
}

-(void)referencingTableChanged:(NSNotification *)not{
    [self.referencingTableButton setTitle:(NSString *)not.object forState:UIControlStateNormal];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"moveToSubmission"]) {
        NSMutableDictionary *cons = [self.dataSource consObject];
        [cons setObject:[NSNumber numberWithBool:self.deferrableSwitch.on] forKey:@"deferrable"];
        [cons setObject:self.constraintNameTextField.text forKey:@"constraintName"];
        NSString *consOb = [self dictionaryToJSON:cons];
        EDJTableSubmissionViewController *submission = segue.destinationViewController;
        [submission performAction:^(UIViewController *current){
            [[EDJTableServices sharedInstance] addFKConstraintWithName:@"" table:[self.table getName] cons:consOb withCompletion:^(BOOL complete){
                [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                    [current dismissViewControllerAnimated:true completion:nil];
                }];
            } withError:^(NSString *error){
                [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:[NSString stringWithFormat:@"error %@", error] delegate:nil cancelButtonTitle:@"Done" otherButtonTitles: nil];
                    [alert show];
                    [current.navigationController popViewControllerAnimated:YES];
                }];
            }];
        }];
        
    }
}

- (NSString*)dictionaryToJSON:(NSDictionary*)dictionary
{
    NSError* error;
    NSData* data = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    return [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
}

@end
