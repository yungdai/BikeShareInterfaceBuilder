//
//  HTTPCommunication.h
//  BikeShareInterfaceBuilder
//
//  Created by Yung Dai on 2015-05-06.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HTTPCommunication : NSObject <NSURLSessionDownloadDelegate>

// successBlock will contain the blcok you're going to call when the request is completed
@property (copy, nonatomic) void (^sucessBlock)(NSData *);

// Craft and request using NSURLREequest and NSURLConnection
- (void) retrieve:(NSURL *) url successBlock:(void(^)(NSData *))successBlock;

// Task has finished downloading delegate method
- (void) URLSession:(NSURLSession *)session
       downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location;


@end
