//
//  EDJWebImageView.m
//  SoftwareEngineering
//
//  Created by Chris Mays on 11/11/14.
//  Copyright (c) 2014 Chris Mays. All rights reserved.
//

#import "EDJWebImageView.h"

@implementation EDJWebImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setImageWithURL:(NSURL *)url chacheImageToDefaultsKey:(NSString *)key{
   /* NSLog(@"%@", [url absoluteString]);
    NSURLRequest *req=[[NSURLRequest alloc] initWithURL:url];
   imageData=[[NSMutableData alloc] init];
    NSURLConnection *con=[[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:false];
    [con scheduleInRunLoop:[NSRunLoop mainRunLoop]
                          forMode:NSDefaultRunLoopMode];
    [con start];*/
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if(data==nil){
                    NSLog(@"data");
                }
                [self setImage:[UIImage imageWithData:data]];
                NSLog(@"made it");
                 NSLog(@"error %@", error);
                [[NSUserDefaults standardUserDefaults] setValue:data forKey:key];
            }] resume];
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"response");
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"response");

    [imageData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    self.image=[UIImage imageWithData:imageData];
    NSLog(@"done");
    imageData=nil;
}
@end
