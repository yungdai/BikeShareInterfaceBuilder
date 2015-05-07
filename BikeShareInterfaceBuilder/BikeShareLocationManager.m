//
//  BikeShareLocationManager.m
//  BikeShareInterfaceBuilder
//
//  Created by Yung Dai on 2015-05-06.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//

#import "BikeShareLocationManager.h"

@implementation BikeShareLocationManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        _http = [[HTTPCommunication alloc]init];
    }
    return self;
}

// parsing data method, it requires a block of code to run and have and be successful
- (void)getBikeShareLocationsOnSucess:(void (^)(NSArray *locations))success {
    NSURL *url = [NSURL URLWithString:@"http://www.bikesharetoronto.com/stations/json"];
    [_http retrieve:url successBlock:^(NSData * response) {
        NSError *error  = nil;
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:response options:0 error:&error];
        NSLog(@"%@", response);
        NSLog(@"%@",data);
        
        
        
        if (!error) {
            NSArray *value = [data valueForKey:@"stationBeanList"];
            // create an array to store the final bikeShareLocations
            NSMutableArray *bikeShareLocations = [[NSMutableArray alloc]init];
            for (NSDictionary *results in value) {
                // create a BikeShareLocation Object
                BikeShareLocation *bikeShareLocation = [BikeShareLocation new];
                // assign all the properties fromt the BikeShareLocation Class
                bikeShareLocation.title = results[@"stationName"];
                NSNumber *avaibleBikes = results[@"availableBikes"];
                bikeShareLocation.subtitle = [NSString stringWithFormat:@"Available Bikes: %@", [avaibleBikes stringValue]];
                NSNumber *latitude = results[@"latitude"];
                NSNumber *longitude = results[@"longitude"];
                bikeShareLocation.coordinate = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
                [bikeShareLocations addObject:bikeShareLocation];
            }
            
            
            // if the parsing is the value of success is my bikeShareLocation
            if (success)
            {
                success(bikeShareLocations);
            }
        }
    }];
}


@end
