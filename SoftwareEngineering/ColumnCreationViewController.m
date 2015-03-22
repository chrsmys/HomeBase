//
//  ColumnCreationViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/16/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "ColumnCreationViewController.h"
#import "EDJTableCreationRequest.h"
#import "EDJColumnCreationView.h"
#import "EDJPrimaryKeyFinalViewController.h"
@interface ColumnCreationViewController ()
@property (nonatomic) NSMutableArray *columnViews;
@end

@implementation ColumnCreationViewController

const NSUInteger columnCreationHeight = 300;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.columnViews = [[NSMutableArray alloc] init];
    self.columnViews = [[NSMutableArray alloc] init];
    [self createUI];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    [self setTitle:[self.tableRequest tableName]];
    

}

-(void)createUI{
    for (int i=0; i<[self.tableRequest expectedColumnCount]; i++) {
        EDJColumnCreationView *creationView = [EDJColumnCreationView getView];
        [creationView setFrame:CGRectMake(0, i*columnCreationHeight, self.columnListScrollView.frame.size.width, columnCreationHeight)];
        [self.columnListScrollView addSubview:creationView];
        [self.columnViews addObject:creationView];
    }
    [self.columnListScrollView setContentSize:CGSizeMake(self.columnListScrollView.frame.size.width, [self.tableRequest expectedColumnCount]*columnCreationHeight+40)];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [doneButton setFrame:CGRectMake(self.columnListScrollView.frame.size.width-100, ([self.tableRequest expectedColumnCount]*columnCreationHeight)-40, 100, 40)];
    [doneButton.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:16]];
    [doneButton setTitle:@"Next \uf105" forState:UIControlStateNormal];
    [self.columnListScrollView addSubview:doneButton];
    [doneButton addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
}
-(void)setTableRequest:(EDJTableCreationRequest *)tableRequest{
    _tableRequest=tableRequest;
    [self createUI];
}
-(void)goNext{
        [self performSegueWithIdentifier:@"moveToPrimaryKeyConstraint" sender:self];
   
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"moveToPrimaryKeyConstraint"]) {
        if([segue.destinationViewController isKindOfClass:[EDJPrimaryKeyFinalViewController class]]){
            NSLog(@"made it");
            EDJPrimaryKeyFinalViewController *primaryKeyFinal = segue.destinationViewController;
            [self.tableRequest.listOfPrimaryKeys removeAllObjects];
            [self.tableRequest.listOfPossibleFKNames removeAllObjects];
            [self.tableRequest.primaryKey removeAllObjects];
            [self.tableRequest.columns removeAllObjects];
            [self.tableRequest.foriegnKeys removeAllObjects];
            for (int i=0; i<[self.columnViews count]; i++) {
                NSLog(@"column View here");
                EDJColumnCreationView *creationView = [self.columnViews objectAtIndex:i];
                [self.tableRequest addColumnWithName:creationView.columnNameTextField.text type:creationView.columnTypeTextField.text size:creationView.columnSizeTextField.text.intValue notNull:[creationView notNull] unique:[creationView unique]];
                
                if(creationView.primaryKey){
                    NSLog(@"herE");
                    [self.tableRequest.listOfPrimaryKeys addObject:creationView.columnNameTextField.text];
                }
                if(creationView.foreignKey){
                    [self.tableRequest.listOfPossibleFKNames addObject:creationView.columnNameTextField.text];
                }
            
            }
            primaryKeyFinal.tableRequest=self.tableRequest;
        }
    }
}
-(BOOL)containsPK{
    for (int i=0; i<[self.columnViews count]; i++) {
        NSLog(@"column View here");
        EDJColumnCreationView *creationView = [self.columnViews objectAtIndex:i];
        [self.tableRequest addColumnWithName:creationView.columnNameTextField.text type:creationView.columnTypeTextField.text size:creationView.columnSizeTextField.text.intValue notNull:[creationView notNull] unique:[creationView unique]];
        
        if(creationView.primaryKey){
            return true;
        }
        
    }
    return false;

}
-(BOOL)containsFK{
    for (int i=0; i<[self.columnViews count]; i++) {
        NSLog(@"column View here");
        EDJColumnCreationView *creationView = [self.columnViews objectAtIndex:i];
        [self.tableRequest addColumnWithName:creationView.columnNameTextField.text type:creationView.columnTypeTextField.text size:creationView.columnSizeTextField.text.intValue notNull:[creationView notNull] unique:[creationView unique]];
        
        if(creationView.foreignKey){
            return true;
        }
        
        
    }
    return false;
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
