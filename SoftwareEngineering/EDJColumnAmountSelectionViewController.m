//
//  EDJColumnAmountSelectionViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/16/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "EDJColumnAmountSelectionViewController.h"
#import "EDJTableServices.h"
#import "EDJTableCreationRequest.h"
#import "ColumnCreationViewController.h"
@interface EDJColumnAmountSelectionViewController ()

@end

@implementation EDJColumnAmountSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(int)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 50;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"%d", row+1];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"moveToColumnCreation"]) {
        if ([segue.destinationViewController isKindOfClass:[ColumnCreationViewController class]]) {
            EDJTableCreationRequest *request = [[EDJTableCreationRequest alloc] init];
            [request setTableName:self.tableNameTextField.text];
            [request setExpectedColumnCount:[self.picketView selectedRowInComponent:0]+1];
            ColumnCreationViewController *creationView = (ColumnCreationViewController *)segue.destinationViewController;
            [creationView setTableRequest:request];
        }
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelButtonPress:(id)sender {
    [self dismissViewControllerAnimated:true completion:(id)0];
}
@end
