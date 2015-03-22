//
//  EDJWebImageView.h
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/11/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDJWebImageView : UIImageView <NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    NSMutableData *imageData;
}
-(void)setImageWithURL:(NSURL *)url;
-(void)setImageWithURL:(NSURL *)url chacheImageToDefaultsKey:(NSString *)key;
@end
