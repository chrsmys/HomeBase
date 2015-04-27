//
//  ViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 10/29/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "EDJTable.h"
#import "EDJUser.h"
#import "EDJTableServices.h"
#import "EDJAccountManager.h"
#import "SVPullToRefresh.h"

@interface ViewController ()

@end

@implementation ViewController {
    int count;
    UIView* leftView;
    UIView* view;
    NSMutableArray* tableList;
}
@synthesize tableCollection;
@synthesize username;

@synthesize viewTitleLabel;
- (void)awakeFromNib
{
}

- (instancetype)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    tableCollection.backgroundColor = [UIColor colorWithRed:0.871 green:0.933 blue:0.988 alpha:1];
    self.view.backgroundColor = [UIColor colorWithRed:0.125 green:0.42 blue:0.608 alpha:1];
    viewTitleLabel.textColor = [UIColor whiteColor];
    menuShowing = false;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refresh)
                                                 name:@"refresh"
                                               object:nil];
    UIPinchGestureRecognizer* pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [tableCollection addGestureRecognizer:pinch];
    [tableCollection addPullToRefreshWithActionHandler:^(void) {
        [self refresh];
    }];
    // [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewDidAppear:(BOOL)animated
{
    [self refresh];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)pinch:(UIPinchGestureRecognizer*)pinch
{
}
- (void)refresh
{
    if ([[EDJUser sharedInstance] getDBUsername]) {
        [_activityIndicator startAnimating];
        [[EDJTableServices sharedInstance] refreshSchema];
        [[EDJTableServices sharedInstance] setDelegate:self];
        [self.usernameLabel setText:[[EDJUser sharedInstance] getDBUsername]];
    }
    else {
        [self.activityIndicator stopAnimating];
    }
    tableList = [[NSMutableArray alloc] init];
    [tableCollection reloadData];
    tableCollection.backgroundColor = [UIColor colorWithRed:0.871 green:0.933 blue:0.988 alpha:1];
    self.view.backgroundColor = [UIColor colorWithRed:0.125 green:0.42 blue:0.608 alpha:1];
    viewTitleLabel.textColor = [UIColor whiteColor];
}
- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    NSLog(@"moved");
}
- (void)menuViewToPercentage:(CGFloat*)per
{
    CATransform3D tran = CATransform3DIdentity;
}

#pragma mark UICollectionViewDelegate methods
- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [tableList count];
}
- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Custom" forIndexPath:indexPath];
    UIPinchGestureRecognizer* pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinched:)];
    UILongPressGestureRecognizer* longpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    longpress.minimumPressDuration = 0.5;
    [cell addGestureRecognizer:pinch];
    [cell addGestureRecognizer:longpress];
    UILabel* lab = (UILabel*)[cell viewWithTag:300];
    EDJTable* tab = ((EDJTable*)[tableList objectAtIndex:indexPath.row]);
    lab.text = [tab getName];
    [lab.layer setBorderWidth:10];
    lab.backgroundColor = [UIColor clearColor];
    [lab.layer setBorderColor:[UIColor colorWithRed:0.953 green:0.533 blue:0.388 alpha:1].CGColor];
    [cell.layer setBorderWidth:10];
    [cell.layer setBorderColor:lab.layer.borderColor];
    cell.backgroundColor = [UIColor whiteColor];
    UILabel* columns = (UILabel*)[cell viewWithTag:-1];
    columns.attributedText = [tab getPreviewOfColumns:5];
    [cell setTag:indexPath.row];
    return cell;
}

- (void)longPress:(UILongPressGestureRecognizer*)press
{
    if ([press state] == UIGestureRecognizerStateBegan) {
        [press locationInView:self.view];
        if (cloneView.superview != nil) {
            [cloneView removeFromSuperview];
            clone.clonedCell.hidden = false;
        }
        clone = [self.storyboard instantiateViewControllerWithIdentifier:@"CloneView"];
        cloneView = clone.view;
        UILabel* cellLabel = (UILabel*)[press.view viewWithTag:300];
        clone.tableNameLabel.layer.borderColor = cellLabel.layer.borderColor;
        clone.tableNameLabel.layer.borderWidth = 10;

        clone.tableNameLabel.text = cellLabel.text;
        clone.clonedCell = (UICollectionViewCell*)press.view;
        [cloneView layoutIfNeeded];
        [cloneView setFrame:CGRectMake([press locationInView:self.view].x, [press locationInView:self.view].y, press.view.frame.size.width, press.view.frame.size.height)];
        cloneView.center = [press locationInView:self.view];
        [cloneView setBackgroundColor:[UIColor whiteColor]];
        [cloneView.layer setBorderWidth:10];
        [cloneView.layer setBorderColor:[UIColor colorWithRed:0.953 green:0.533 blue:0.388 alpha:1].CGColor];
        EDJTable* tab = ((EDJTable*)[tableList objectAtIndex:press.view.tag]);
        clone.columnsListView.attributedText = [tab getAllColumnsToString];
        [self.view insertSubview:cloneView belowSubview:self.trashcan];
        press.view.hidden = true;
        tableCollection.userInteractionEnabled = false;
        self.trashcan.hidden = false;
    }
    else if ([press state] == UIGestureRecognizerStateEnded || [press state] == UIGestureRecognizerStateCancelled || [press state] == UIGestureRecognizerStateFailed) {

        tableCollection.userInteractionEnabled = true;

        if (CGRectIntersectsRect(cloneView.frame, self.trashcan.frame)) {
            cloneView.alpha = 1.0;
            [cloneView genieInTransitionWithDuration:1.0 destinationRect:self.trashcan.frame destinationEdge:BCRectEdgeTop completion:^(void) {
                self.trashcan.hidden=true;
                press.view.hidden=false;
                [cloneView removeFromSuperview];
                [[EDJTableServices sharedInstance] dropTable:clone.tableNameLabel.text];
            }];
        }
        else {
            press.view.hidden = false;
            self.trashcan.hidden = true;
            [cloneView removeFromSuperview];
        }
    }
    else {
        cloneView.frame = CGRectMake([press locationInView:self.view].x, [press locationInView:self.view].y, cloneView.frame.size.width, cloneView.frame.size.height);

        cloneView.center = [press locationInView:self.view];
        if (CGRectIntersectsRect(cloneView.frame, self.trashcan.frame)) {
            cloneView.alpha = 0.5;
        }
        else {
            cloneView.alpha = 1.0;
        }
    }
}

- (void)pinched:(UIPinchGestureRecognizer*)pin
{
    if ([pin state] == UIGestureRecognizerStateBegan) {
        if (cloneView.superview != nil) {
            [cloneView removeFromSuperview];
            clone.clonedCell.hidden = false;
        }
        clone = [self.storyboard instantiateViewControllerWithIdentifier:@"CloneView"];
        [clone setTable:[tableList objectAtIndex:pin.view.tag]];
        cloneView = clone.view;
        UILabel* cellLabel = (UILabel*)[pin.view viewWithTag:300];
        clone.tableNameLabel.layer.borderColor = cellLabel.layer.borderColor;
        clone.tableNameLabel.layer.borderWidth = 10;
        NSLog(@"pin tag %d", pin.view.tag);
        clone.tableNameLabel.text = cellLabel.text;
        clone.clonedCell = (UICollectionViewCell*)pin.view;
        [cloneView layoutIfNeeded];
        [cloneView setFrame:CGRectMake([pin locationInView:self.view].x, [pin locationInView:self.view].y, pin.view.frame.size.width, pin.view.frame.size.height)];
        [cloneView setBackgroundColor:[UIColor whiteColor]];
        [cloneView.layer setBorderWidth:10];
        [cloneView.layer setBorderColor:[UIColor colorWithRed:0.953 green:0.533 blue:0.388 alpha:1].CGColor];
        EDJTable* tab = ((EDJTable*)[tableList objectAtIndex:pin.view.tag]);
        clone.columnsListView.attributedText = [tab getAllColumnsToString];

        [self.view addSubview:cloneView];
        pin.view.hidden = true;
        tableCollection.userInteractionEnabled = false;
    }
    else if ([pin state] == UIGestureRecognizerStateEnded || [pin state] == UIGestureRecognizerStateCancelled | [pin state] == UIGestureRecognizerStateFailed) {

        tableCollection.userInteractionEnabled = true;

        if (pin.scale >= 2) {
            cloneView.frame = self.view.frame;
        }
        else {
            [UIView animateWithDuration:0.2 animations:^(void) {
             //   cloneView.frame=pin.view.frame;
                
                cloneView.frame=[tableCollection convertRect:pin.view.frame toView:self.view];
                [cloneView layoutIfNeeded];
            } completion:^(BOOL finished) {
               [cloneView removeFromSuperview];
                pin.view.hidden=false;
            }];
        }
    }
    else {
        cloneView.frame = CGRectMake([pin locationInView:self.view].x, [pin locationInView:self.view].y, MAX(pin.view.frame.size.width - 50, 300 * pin.scale), MAX(pin.view.frame.size.height - 50, 300 * pin.scale));

        cloneView.center = [pin locationInView:self.view];
    }
}
- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath
{
    UICollectionViewCell* cells = [collectionView cellForItemAtIndexPath:indexPath];
    clone = [self.storyboard instantiateViewControllerWithIdentifier:@"CloneView"];
    [clone setTable:[tableList objectAtIndex:indexPath.row]];
    cloneView = clone.view;
    UILabel* cellLabel = (UILabel*)[cells viewWithTag:300];
    clone.tableNameLabel.layer.borderColor = cellLabel.layer.borderColor;
    clone.tableNameLabel.layer.borderWidth = 10;

    clone.tableNameLabel.text = cellLabel.text;
    clone.clonedCell = cells;
    [cloneView setBackgroundColor:[UIColor whiteColor]];
    [cloneView.layer setBorderWidth:10];
    [cloneView.layer setBorderColor:[UIColor colorWithRed:0.953 green:0.533 blue:0.388 alpha:1].CGColor];
    [self.view addSubview:cloneView];
    cells.hidden = true;
    cloneView.frame = cells.frame;

    EDJTable* tab = ((EDJTable*)[tableList objectAtIndex:indexPath.row]);
    clone.columnsListView.attributedText = [tab getAllColumnsToString];
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^(void) {
        
        cloneView.frame=self.view.frame;
        [cloneView layoutIfNeeded];
        [clone.tableInfoContainer layoutIfNeeded];

    } completion:nil];
}

- (void)didReceiveMemoryWarning
{

    [super didReceiveMemoryWarning];
}

- (IBAction)menuButtonPressed:(id)sender
{

    [self.delegate menuButtonWasPressed];
}

#pragma MARK - TableServices Delegate
- (void)tableSchemaUpdated
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_activityIndicator setHidesWhenStopped:true];
        [_activityIndicator stopAnimating];
        [tableCollection.pullToRefreshView stopAnimating];
        tableList = [[NSMutableArray alloc] initWithArray:[[EDJTableServices sharedInstance] tables]];
        [tableCollection reloadData];
        
        if (clone!=nil && clone.view.superview!=nil ) {
            EDJTable *table = [[EDJTableServices sharedInstance] getTableObjectWithName:[clone.table getName]];
            [self deployUpdatedCloneWithTable:table];
        }
    });
}

- (void)deployUpdatedCloneWithTable:(EDJTable*)table
{
    UICollectionViewCell* cells = clone.clonedCell;
    [clone.view removeFromSuperview];
    clone = nil;

    clone = [self.storyboard instantiateViewControllerWithIdentifier:@"CloneView"];
    [clone setTable:table];
    cloneView = clone.view;
    UILabel* cellLabel = (UILabel*)[cells viewWithTag:300];
    clone.tableNameLabel.layer.borderColor = cellLabel.layer.borderColor;
    clone.tableNameLabel.layer.borderWidth = 10;

    clone.tableNameLabel.text = [table getName];
    clone.clonedCell = cells;
    [cloneView setBackgroundColor:[UIColor whiteColor]];
    [cloneView.layer setBorderWidth:10];
    [cloneView.layer setBorderColor:[UIColor colorWithRed:0.953 green:0.533 blue:0.388 alpha:1].CGColor];
    [self.view addSubview:cloneView];
    cloneView.frame = cells.frame;
    clone.columnsListView.attributedText = [table getAllColumnsToString];
    cloneView.frame = self.view.frame;
    [cloneView layoutIfNeeded];
    [clone.tableInfoContainer layoutIfNeeded];
}

- (void)failedToDropTable:(NSString*)tableName withError:(NSDictionary*)error
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"error" message:[error objectForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
@end
