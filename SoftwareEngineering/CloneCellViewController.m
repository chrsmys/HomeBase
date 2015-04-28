//
//  CloneCellViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/20/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import "CloneCellViewController.h"
#import "EDJTable.h"
#import "EditTableNameViewController.h"
#import "TableInfoViewController.h"
#import "UIView+Borders.h"
#import "UIColor+EDJSystemColors.h"
#import "RZSquaresLoading.h"
@interface CloneCellViewController ()
@property (nonatomic) RZSquaresLoading *squareLoading;
@end

@implementation CloneCellViewController
@synthesize cloneCellView;
@synthesize tableNameLabel;
@synthesize clonedCell;
- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}
- (void)viewDidLoad
{
    UIPinchGestureRecognizer* pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinched:)];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];
    [self.view addGestureRecognizer:pinch];
    self.foriegnKeysList.text = [self.table getForeignKeyText];
    if (self.table) {
    }
    else {
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"refreshSchema" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nameChange:) name:@"tableNameChanged" object:nil];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setTable:(EDJTable*)table
{
    _table = table;

    if (table) {
    }
    self.foriegnKeysList.text = [self.table getForeignKeyText];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tapped:(UITapGestureRecognizer*)tp
{
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^(void) {
            [self.view layoutIfNeeded];
            self.view.frame=[clonedCell.superview convertRect:clonedCell.frame toView:self.view.superview];
            [self.view layoutIfNeeded];
            for(UIView *vi in [self.view subviews]){
                [vi layoutIfNeeded];
                for(UIView *vii in [vi subviews]){
                    [vii layoutIfNeeded];
                }
            }
    } completion:^(BOOL fin) {
        [clonedCell setHidden:false];
        [self.view removeFromSuperview];

    }];
}
- (void)pinched:(UIPinchGestureRecognizer*)pin
{
    self.view.frame = CGRectMake(0, 0, self.view.superview.frame.size.height * pin.scale, self.view.superview.frame.size.height * pin.scale);
    self.view.center = CGPointMake([pin locationInView:self.view.superview].x, [pin locationInView:self.view.superview].y);
    NSLog(@"pin loc %f %f", [pin locationInView:self.parentViewController.view].x, [pin locationInView:self.parentViewController.view].y);
    if ([pin state] == UIGestureRecognizerStateEnded) {
        if (pin.scale < 0.75) {
            [UIView animateWithDuration:0.2 animations:^(void) {
                self.view.frame=[clonedCell.superview convertRect:clonedCell.frame toView:self.view.superview];
            } completion:^(BOOL fin) {
                [clonedCell setHidden:false];
                [self.view removeFromSuperview];

            }];
        }
        else {
            [UIView animateWithDuration:0.2 animations:^(void) {
                self.view.frame=clonedCell.frame;
                self.view.frame=CGRectMake(0,0,self.view.superview.frame.size.width, self.view.superview.frame.size.height);
            }];
        }
    }
}
- (void)viewDidLayoutSubviews
{
    _columnsListView.font = [UIFont fontWithName:_columnsListView.font.fontName size:24];

    _columnsListView.textAlignment = UITextAlignmentCenter;
    float maxBound = MAX(self.view.frame.size.height, self.view.frame.size.width);
    self.containerView.alpha = (maxBound - 300) / 600;
    if (self.view.superview.frame.size.width - 40 < self.view.frame.size.width) {
        self.containerView.alpha = 1;
    }
    
    if([self.squareLoading superview]){
        [self.squareLoading.superview bringSubviewToFront:self.squareLoading];
    }
    
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
// preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showEditTableName"]) {
        NSLog(@"key is right");
        UIViewController* destination = segue.destinationViewController;
        if ([destination isKindOfClass:[UINavigationController class]]) {
            destination = [
                [((UINavigationController*)destination)viewControllers] firstObject];
            NSLog(@"nav");
        }
        if ([destination isKindOfClass:[EditTableNameViewController class]]) {
            EditTableNameViewController* dest = (EditTableNameViewController*)destination;
            [dest setTableName:[self.table getName]];
        }
    }
    else if ([segue.identifier isEqualToString:@"TableInfoSegue"]) {
        if ([segue.destinationViewController
                isKindOfClass:[TableInfoViewController class]]) {
            TableInfoViewController* tableInfo = (TableInfoViewController*)segue.destinationViewController;
            tableInfo.table = self.table;
            tableInfo.view.backgroundColor = [UIColor systemOrange];
            NSLog(@"doing this %@", self.table);
        }
    }
}

-(void)refresh{
    NSLog(@"CalleD");
    self.squareLoading = [[RZSquaresLoading alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, 100, 100)];
    [self.squareLoading setColor:[UIColor redColor]];
    [self.containerView addSubview:self.squareLoading];
    self.view.userInteractionEnabled=false;
}
-(void)nameChange:(NSNotification *)notification{
    [self.table setName:notification.object];
    
    self.tableNameLabel.text=[self.table getName];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshSchema" object:nil];
}

@end
