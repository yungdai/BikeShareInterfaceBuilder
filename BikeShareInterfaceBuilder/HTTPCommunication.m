//
//  HTTPCommunication.m
//  BikeShareInterfaceBuilder
//
//  Created by Yung Dai on 2015-05-06.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//

#import "HTTPCommunication.h"

@implementation HTTPCommunication

- (void)retrieve:(NSURL *)url successBlock:(void (^)(NSData *))successBlock
{
    // persisting given successBlock for calling it later
    self.sucessBlock = successBlock;
    // creating the request using the given url
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    //set the default configuration
    NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultSessionConfiguration];
    // setup the session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:conf delegate:self delegateQueue:nil];
    // preparing the download path
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request];
    // establih the connection
    [task resume];
}

- (void) URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    // getting the download data from the local storage
    NSData *data = [NSData dataWithContentsOfURL:location];
    // ensure that you call the successBlock from the main thread by using the dispatch
    dispatch_async(dispatch_get_main_queue(), ^{
        self.sucessBlock(data);
    });
    
    
    
}
@end
