//
//  NSAttributedString+Constructors.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 3/4/15.
//  Copyright (c) 2015 Chris Mays. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSAttributedString (Constructors)
+ (NSAttributedString*)returnNSAttributedString:(NSString*)string range:(NSRange)range WithColour:(UIColor*)colour WithUnderLine:(BOOL)underline;
+ (NSAttributedString*)returnNSAttributedStringWithAttributedString:(NSAttributedString *)string range:(NSRange)range WithColour:(UIColor*)color WithUnderLine:(BOOL)underline;
@end
