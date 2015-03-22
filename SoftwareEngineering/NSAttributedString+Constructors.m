//
//  NSAttributedString+Constructors.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/4/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import "NSAttributedString+Constructors.h"
#import <UIKit/UIKit.h>
@implementation NSAttributedString (Constructors)

+ (NSAttributedString*)returnNSAttributedString:(NSString*)string range:(NSRange)range WithColour:(UIColor*)colour WithUnderLine:(BOOL)underline {
    NSMutableAttributedString *attributedString =
    [[NSMutableAttributedString alloc] initWithString:string];
    if (underline) {
        [attributedString addAttributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)} range:range];
    }
    [attributedString addAttribute:NSForegroundColorAttributeName value:colour range:range];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSRangeFromString(string)];
    return attributedString;
}

@end
