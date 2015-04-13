//
//  AddNewColumnViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/5/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "AddNewColumnViewController.h"
#import "EDJTableSubmissionViewController.h"
#import "EDJTableServices.h"
@interface AddNewColumnViewController ()

@end

@implementation AddNewColumnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewDidAppear:(BOOL)animated{
    _columnCreationView = [EDJColumnCreationView getViewWithOutFKAddition];
    _columnCreationView.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height);
    [self setFields];
    [self.view addSubview:_columnCreationView];
}

-(void)setFields{
    if (self.column != nil) {
        [self setTitle:@"Edit Column"];
        _columnCreationView.columnNameTextField.text = [self.column name];
        _columnCreationView.columnTypeTextField.text = [self.column type];
        _columnCreationView.columnTypeTextField.enabled = false;
        _columnCreationView.columnTypeTextField.textColor = [UIColor lightGrayColor];
        _columnCreationView.columnSizeTextField.text = [self.column formattedSize];
        
        _columnCreationView.notNullButton.hidden=true;
        _columnCreationView.uniqueButton.hidden=true;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)cancelButtonPressed:(id)sender {
 [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"moveToSubmission"]) {
        if ([segue.destinationViewController isKindOfClass:[EDJTableSubmissionViewController class]]) {
            EDJTableSubmissionViewController *destin = (EDJTableSubmissionViewController *)segue.destinationViewController;
            if (self.column==nil) {
                [self performCreateColumnAction:destin];
            }else{
                if (![[self.column name] isEqualToString:self.columnCreationView.columnNameTextField.text]) {
                    [self performActionChangeColumnNameAndAttributes:destin];
                }else{
                    [self performAction:destin];
        }
    }

    
}
    }
}

-(void)performCreateColumnAction:(EDJTableSubmissionViewController *)tableSubmissionView{
    [tableSubmissionView performAction:^(UIViewController *controller){
        [[EDJTableServices sharedInstance] addColumnWithTableName:[self.table getName] columnName:_columnCreationView.columnNameTextField.text columnType:_columnCreationView.columnTypeTextField.text columnLength:[_columnCreationView.columnSizeTextField.text intValue] notNull:_columnCreationView.notNull isUnique:_columnCreationView.unique withCompletion:^(BOOL complete){
            
            [controller dismissViewControllerAnimated:true completion:nil];
            
        }withError:^(NSString *error){
           [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:error delegate:nil cancelButtonTitle:@"Done" otherButtonTitles: nil];
                [alert show];
                [controller.navigationController popToRootViewControllerAnimated:YES];
           }];
        }];
    }];

}

-(void)performActionChangeColumnNameAndAttributes:(EDJTableSubmissionViewController *)tableSubmissionView{
    [tableSubmissionView performAction:^(UIViewController *controller){
        
        [[EDJTableServices sharedInstance] renameColumninTable:[self.table getName] oldColumnName:[self.column name] newColumnName:self.columnCreationView.columnNameTextField.text withCompletion:^(BOOL complete){
        
                [[EDJTableServices sharedInstance] editColumnWithTableName:[self.table getName] columnName:_columnCreationView.columnNameTextField.text columnType:_columnCreationView.columnTypeTextField.text columnLength:_columnCreationView.columnSizeTextField.text withCompletion:^(BOOL complete){
                    
                    [controller dismissViewControllerAnimated:true completion:nil];
                    
                } withError:^(NSString *error){
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:[NSString stringWithFormat:@"error %@", error] delegate:nil cancelButtonTitle:@"Done" otherButtonTitles: nil];
                        [alert show];
                        [controller.navigationController popViewControllerAnimated:YES];
                    }];
                }];
        
        
        } withError:^(NSString *error){
            [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:[NSString stringWithFormat:@"error %@", error] delegate:nil cancelButtonTitle:@"Done" otherButtonTitles: nil];
                [alert show];
                [controller.navigationController popViewControllerAnimated:YES];
            }];
        }];
        
        
        
        
        
        
    }];
}

-(void)performAction:(EDJTableSubmissionViewController *)tableSubmissionView{
    [tableSubmissionView performAction:^(UIViewController *controller){
        [[EDJTableServices sharedInstance] editColumnWithTableName:[self.table getName] columnName:_columnCreationView.columnNameTextField.text columnType:_columnCreationView.columnTypeTextField.text columnLength:_columnCreationView.columnSizeTextField.text withCompletion:^(BOOL complete){
            
            [controller dismissViewControllerAnimated:true completion:nil];
            
        }withError:^(NSString *error){
            [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:[NSString stringWithFormat:@"error %@", error] delegate:nil cancelButtonTitle:@"Done" otherButtonTitles: nil];
                [alert show];
                [controller.navigationController popViewControllerAnimated:YES];
            }];
        }];
    }];
}


@end
