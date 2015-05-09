//
//  BikeShareLocationManager.h
//  BikeShareInterfaceBuilder
//
//  Created by Yung Dai on 2015-05-06.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPCommunication.h"
#import "BikeShareLocation.h"


@interface BikeShareLocationManager : NSObject

// get the ability to initialise the HTTP string
@property (strong, nonatomic) HTTPCommunication *http;


// create a method that parses the JSON
- (void)getBikeShareLocationsOnSucess:(void (^)(NSArray *locations))success;


@end
