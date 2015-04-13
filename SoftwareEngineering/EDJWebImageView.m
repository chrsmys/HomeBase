//
//  EDJWebImageView.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/11/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import "EDJWebImageView.h"

@implementation EDJWebImageView

- (void)setImageWithURL:(NSURL*)url chacheImageToDefaultsKey:(NSString*)key
{
    NSURLSession* session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url
            completionHandler:^(NSData* data,
                                  NSURLResponse* response,
                                  NSError* error) {
                [self setImage:[UIImage imageWithData:data]];
                [[NSUserDefaults standardUserDefaults] setValue:data forKey:key];
            }] resume];
}
- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response
{
}
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    [imageData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    self.image = [UIImage imageWithData:imageData];
    imageData = nil;
}
@end
