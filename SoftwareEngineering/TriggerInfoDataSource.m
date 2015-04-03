//
//  TriggerInfoDataSource.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/29/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "TriggerInfoDataSource.h"
#import "EDJTrigger.h"
#import "TriggerInfoTableViewCell.h"
@implementation TriggerInfoDataSource

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.table triggers] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EDJTrigger *trigger = [[self.table triggers] objectAtIndex:indexPath.row];
    TriggerInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.triggerNameLabel.text=[trigger name];
    [cell setActive:[trigger isActive]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EDJTrigger *trigger = [[self.table triggers] objectAtIndex:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(selectedTrigger:)]) {
        [self.delegate selectedTrigger:trigger];
    }
    [self.delegate selectedTrigger:trigger];
}

@end
