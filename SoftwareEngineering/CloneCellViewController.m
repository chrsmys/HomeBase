//
//  CloneCellViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/20/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import "CloneCellViewController.h"
#import "EDJTable.h"
#import "FKListViewController.h"
@interface CloneCellViewController ()

@end

@implementation CloneCellViewController
@synthesize cloneCellView;
@synthesize tableNameLabel;
@synthesize clonedCell;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}
- (void)viewDidLoad {
    UIPinchGestureRecognizer *pinch=[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinched:)];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    tap.numberOfTapsRequired=2;
    [self.view addGestureRecognizer:tap];
    [self.view addGestureRecognizer:pinch];
    self.foriegnKeysList.text=[self.table getForeignKeyText];
    if (self.table) {
        NSLog(@"table exists here");
    }else{
        NSLog(@"didn't");
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)setTable:(EDJTable *)table{
    _table=table;
    NSLog(@"set");
    if(table){
        NSLog(@"This table is not ni;");
    }
    self.foriegnKeysList.text=[self.table getForeignKeyText];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tapped:(UITapGestureRecognizer *)tp{
        [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^(void){
            [self.view layoutIfNeeded];
            self.view.frame=[clonedCell.superview convertRect:clonedCell.frame toView:self.view.superview];
            [self.view layoutIfNeeded];
            for(UIView *vi in [self.view subviews]){
                [vi layoutIfNeeded];
                for(UIView *vii in [vi subviews]){
                    [vii layoutIfNeeded];
                }
            }
    } completion:^(BOOL fin){
        [clonedCell setHidden:false];
        [self.view removeFromSuperview];
        
    }];
}
-(void)pinched:(UIPinchGestureRecognizer *)pin{
    self.view.frame=CGRectMake(0,0,self.view.superview.frame.size.height*pin.scale, self.view.superview.frame.size.height*pin.scale);
    self.view.center=CGPointMake([pin locationInView:self.view.superview].x, [pin locationInView:self.view.superview].y);
    NSLog(@"pin loc %f %f", [pin locationInView:self.parentViewController.view].x, [pin locationInView:self.parentViewController.view].y);
    if([pin state]==UIGestureRecognizerStateEnded){
        if(pin.scale <0.75){
            [UIView animateWithDuration:0.2 animations:^(void){
                self.view.frame=[clonedCell.superview convertRect:clonedCell.frame toView:self.view.superview];
            } completion:^(BOOL fin){
                [clonedCell setHidden:false];
                [self.view removeFromSuperview];
                
            }];
        }else{
            [UIView animateWithDuration:0.2 animations:^(void){
                self.view.frame=clonedCell.frame;
                self.view.frame=CGRectMake(0,0,self.view.superview.frame.size.width, self.view.superview.frame.size.height);
            }];
        }
        
    }
    
    
    

}
-(void)viewDidLayoutSubviews{
    NSLog(@"%f %f", 1.0-((self.view.frame.size.width-300)/100), (self.view.frame.size.width-300)/100);
    //cloneCellView.alpha=1.0-((self.view.frame.size.width-300)/100);
tableNameLabel.frame=CGRectMake(tableNameLabel.frame.origin.x, tableNameLabel.frame.origin.y, self.view.frame.size.width, tableNameLabel.frame.size.height);
    //tableNameLabel.font=((UILabel *)[clonedCell viewWithTag:-5]).font;
    _columnsListView.font=[UIFont fontWithName:_columnsListView.font.fontName size:24];
    
    _columnsListView.textAlignment=UITextAlignmentCenter;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowFK"]) {
        NSLog(@"key is right");
        UIViewController *destination = segue.destinationViewController;
        if ([destination isKindOfClass:[UINavigationController class]]) {
            destination = [[((UINavigationController *)destination) viewControllers] firstObject];
            NSLog(@"nav");
        }
        if ([destination isKindOfClass:[FKListViewController class]]) {
            FKListViewController *dest = (FKListViewController *)destination;
            dest.fkText=[self.table getForeignKeyText];
            dest.FKTextView.text=[self.table getForeignKeyText];
              NSLog(@"final");
        }
    }
}

@end
