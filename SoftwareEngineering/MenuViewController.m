//
//  MenuViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/17/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import "MenuViewController.h"
#import "EDJAccountManager.h"
@interface MenuViewController ()

@end

@implementation MenuViewController {
    ViewController* mainView;
}
@synthesize delegate;
NSString* const EDIT_CONNECTION_TEXT = @"Add Schema";
NSString* const REFRESH_TEXT = @"Refresh";
NSString* const LOGOUT_TEXT = @"Logout";

- (void)viewDidLoad
{
    [super viewDidLoad];
    menuItems = [[NSMutableArray alloc] init];
    [menuItems addObjectsFromArray:[[EDJAccountManager sharedInstance] getUserNameList]];
    [menuItems addObject:EDIT_CONNECTION_TEXT];

    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
    [menuItems removeAllObjects];
    [menuItems addObjectsFromArray:[[EDJAccountManager sharedInstance] getUserNameList]];
    [menuItems addObject:EDIT_CONNECTION_TEXT];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuItems count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    tableView.backgroundColor = [UIColor colorWithRed:0.953 green:0.533 blue:0.388 alpha:1];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
    cell.backgroundColor = tableView.backgroundColor;
    cell.textLabel.text = [menuItems objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:cell.textLabel.font.fontName size:30];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    if ([[menuItems objectAtIndex:indexPath.row] isEqualToString:LOGOUT_TEXT]) {
        [delegate logoutButtonPressed];
    }
    else if ([[menuItems objectAtIndex:indexPath.row] isEqualToString:EDIT_CONNECTION_TEXT]) {
        [delegate editConnectionButtonPressed];
    }
    else if ([[menuItems objectAtIndex:indexPath.row] isEqualToString:REFRESH_TEXT]) {
        [delegate refreshButtonPressed];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }else{
        NSDictionary *dictionary = [[EDJAccountManager sharedInstance] getUserInfoForUsername:[menuItems objectAtIndex:indexPath.row]];
        [[EDJAccountManager sharedInstance] changeConnectionForCurrentUser:[dictionary objectForKey:@"Username"] password:[dictionary objectForKey:@"Password"] connectionString:[dictionary objectForKey:@"ConnectionString"]];
        [self.delegate newUserSelected];

        //[[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
    }
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 90.0f;
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
