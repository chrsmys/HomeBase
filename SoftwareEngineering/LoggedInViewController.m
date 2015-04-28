//
//  LoggedInViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/17/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import "LoggedInViewController.h"
#import "ViewController.h"
#import "MenuViewController.h"
#import "EDJAccountManager.h"
@interface LoggedInViewController ()

@end

@implementation LoggedInViewController {
    MenuOverlayViewController* mainView;
    MenuViewController* menuView;
}
@synthesize topContainer;
@synthesize menuContainer;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mainView = [self.storyboard instantiateViewControllerWithIdentifier:@"tableViewer"];
    [self addChildViewController:mainView];
    menuShowing = false;
    [topContainer addSubview:mainView.view];
    mainView.delegate = self;

    menuView = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuID"];
    [self addChildViewController:menuView];
    [menuContainer addSubview:menuView.view];
    menuView.delegate = self;

    menuContainer.layer.transform = [self transformWithPercent:0.0];
    menuContainer.layer.anchorPoint = CGPointMake(1.0, 0.5);
    UIPanGestureRecognizer* rec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panning:)];
    [mainView.menuButton addGestureRecognizer:rec];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"refreshSchema" object:nil];

    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    if(([[[EDJAccountManager sharedInstance] getUserNameList] count]==0)) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *nav = [story instantiateViewControllerWithIdentifier:@"Onboarding"];
        [self presentViewController:nav animated:true completion:nil];
        
    }
}

-(void)refresh{
    [mainView viewDidAppear:true];
}
- (void)panning:(UIPanGestureRecognizer*)pan
{
    NSLog(@"pan");
    CGPoint point = [pan translationInView:self.view];
    if (point.x < 0) {
        point = CGPointMake(MAX(300 + point.x, 0), point.y);
    }
    topContainer.frame = CGRectMake(MAX(0, MIN(point.x, 300)), 0, topContainer.frame.size.width, topContainer.frame.size.height);
    menuContainer.layer.transform = [self transformWithPercent:MAX(0, MIN(point.x / 300.0, 1))];
    menuContainer.alpha = MAX(MAX(0, MIN(point.x / 300.0, 1)) * 1.0, 0.5);
    if ([pan state] == UIGestureRecognizerStateEnded) {
        if (MAX(0, MIN(point.x / 300.0, 1)) > 0.5) {
            [UIView animateWithDuration:1.0 - MAX(0, MIN(point.x / 300.0, 1)) animations:^(void) {
                topContainer.frame=CGRectMake(300, 0, topContainer.frame.size.width, topContainer.frame.size.height);
                menuContainer.layer.transform=[self transformWithPercent:1.0];
                menuContainer.alpha=1.0;
            }];
        }
        else {
            [UIView animateWithDuration:MAX(0, MIN(point.x / 300.0, 1)) animations:^(void) {
                topContainer.frame=CGRectMake(0, 0, topContainer.frame.size.width, topContainer.frame.size.height);
                menuContainer.layer.transform=[self transformWithPercent:0.0];
                menuContainer.alpha=0.5;

            }];
        }
    }
    [menuView viewDidAppear:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)menuButtonWasPressed
{
    [menuView viewDidAppear:true];
    if (topContainer.frame.origin.x == 0) {
        [UIView animateWithDuration:1.0 animations:^(void) {
            topContainer.frame=CGRectMake(300, 0, topContainer.frame.size.width,topContainer.frame.size.height);
            menuContainer.layer.transform=[self transformWithPercent:1.0];
            menuContainer.alpha=1.0;
        }];
        menuShowing = true;
    }
    else {
        [UIView animateWithDuration:1.0 animations:^(void) {
            topContainer.frame=CGRectMake(0, 0, topContainer.frame.size.width,topContainer.frame.size.height);
            menuContainer.layer.transform=[self transformWithPercent:0.0];
            menuContainer.alpha=0.4;
        }];
        menuShowing = false;
    }
}
- (void)viewDidLayoutSubviews
{
    NSLog(@"layout");
    NSLog(@"%f ", mainView.view.frame.size.width);
    mainView.view.frame = topContainer.frame;
    menuContainer.frame = CGRectMake(-150, 0, 300, self.view.frame.size.height);
    menuContainer.layer.transform = [self transformWithPercent:0.0];
}

- (void)doPercentageWorkHere
{
}

- (CATransform3D)transformWithPercent:(float)percent
{
    CATransform3D identity = CATransform3DIdentity;
    identity.m34 = -1.0 / 1000;
    float angle = (1.0 - percent) * -((CGFloat)M_PI_2);
    CATransform3D rotationTransform = CATransform3DRotate(identity, angle, 0, 1.0, 0.0);

    CATransform3D translate = CATransform3DMakeTranslation(topContainer.frame.origin.x - 150, topContainer.frame.origin.y, 0);

    NSLog(@"%f %f %f", topContainer.frame.origin.x, menuContainer.frame.size.width, topContainer.frame.origin.x - menuContainer.frame.size.width);
    return CATransform3DConcat(rotationTransform, translate);
}

#pragma mark MenuDelegateMethods
- (void)logoutButtonPressed
{
    [[EDJAccountManager sharedInstance] logoutCurrentUser];
    [self performSegueWithIdentifier:@"logout" sender:nil];
}
- (void)editConnectionButtonPressed
{
    //[mainView editConnectionButtonPressed];
    [self menuButtonWasPressed];
    [self performSegueWithIdentifier:@"editConnection" sender:nil];
}
- (void)refreshButtonPressed
{
    [self menuButtonWasPressed];
    [mainView viewDidAppear:true];
}

-(void)newUserSelected{
    [self menuButtonWasPressed];
    [mainView viewDidAppear:true];
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
