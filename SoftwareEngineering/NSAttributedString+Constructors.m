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

+ (NSAttributedString*)returnNSAttributedString:(NSString*)string range:(NSRange)range WithColour:(UIColor*)color WithUnderLine:(BOOL)underline
{
    NSAttributedString* attributedString = [[NSAttributedString alloc] initWithString:string];
    return [self returnNSAttributedStringWithAttributedString:attributedString range:range WithColour:color WithUnderLine:underline];
}
+ (NSAttributedString*)returnNSAttributedStringWithAttributedString:(NSAttributedString*)string range:(NSRange)range WithColour:(UIColor*)color WithUnderLine:(BOOL)underline
{
    NSMutableAttributedString* attributedString =
        [[NSMutableAttributedString alloc] initWithAttributedString:string];
    if (underline) {
        [attributedString addAttributes:@{ NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle) } range:range];
    }
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
    return attributedString;
}
@end
