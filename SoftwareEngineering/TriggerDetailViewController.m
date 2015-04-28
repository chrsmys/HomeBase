//
//  TriggerDetailViewController.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 4/1/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "TriggerDetailViewController.h"
#import "EDJTrigger.h"
#import "NSAttributedString+Constructors.h"
@interface TriggerDetailViewController ()

@end

@implementation TriggerDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated
{
    NSString* triggerInfo = [NSString stringWithFormat:@"TRIGGER TYPE: %@ \n\n TRIGGERING EVENT: %@ \n\n TRIGER BODY: \n %@ ", [self.trigger type], [self.trigger event], [self.trigger body]];

    NSAttributedString* attributed = [NSAttributedString returnNSAttributedString:triggerInfo range:[triggerInfo rangeOfString:@"TRIGGER TYPE"] WithColour:[UIColor blackColor] WithUnderLine:true];
    attributed = [NSAttributedString returnNSAttributedStringWithAttributedString:attributed range:[triggerInfo rangeOfString:@"TRIGGERING EVENT"] WithColour:[UIColor blackColor] WithUnderLine:true];
    attributed = [NSAttributedString returnNSAttributedStringWithAttributedString:attributed range:[triggerInfo rangeOfString:@"TRIGGER BODY"] WithColour:[UIColor blackColor] WithUnderLine:true];
    self.triggerCodeDisplay.attributedText = attributed;
    self.triggerCodeDisplay.editable = false;

    self.title = [self.trigger name];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTrigger:(EDJTrigger*)trigger
{
    NSString* triggerInfo = [NSString stringWithFormat:@"TRIGGER TYPE : %@ \n TRIGGERING EVENT: %@ \n TRIGER BODY: \n %@ ", [trigger type], [trigger event], [trigger body]];

    self.triggerCodeDisplay.text = triggerInfo;
    self.triggerCodeDisplay.editable = false;
    _trigger = trigger;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doneButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
