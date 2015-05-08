//
//  BikeShareLocationManager.m
//  BikeShareApplication
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
        
        // initialise an HTTPCommunication object called _http
        _http = [[HTTPCommunication alloc]init];
    }
    return self;
}

// parsing data method, it requires a block of code to run and have and be successful
- (void)getBikeShareLocationsOnSucess:(void (^)(NSArray *locations))success {
    NSURL *url = [NSURL URLWithString:@"http://www.bikesharetoronto.com/stations/json"];
    // run the HTTPCommunciation URL request method
    [_http retrieve:url successBlock:^(NSData * response) {
        NSError *error  = nil;
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:response options:0 error:&error];
        NSLog(@"%@", response);
        NSLog(@"%@",data);
        
        
        //  if there are no errors inside the data dictionary
        if (!error) {
            NSArray *value = [data valueForKey:@"stationBeanList"];
            // create an array to store the final bikeShareLocations
            NSMutableArray *bikeShareLocations = [[NSMutableArray alloc]init];
            for (NSDictionary *results in value) {
                // create a BikeShareLocation Object
                BikeShareLocation *bikeShareLocation = [BikeShareLocation new];
                // assign all the properties from the BikeShareLocation Class
                bikeShareLocation.title = results[@"stationName"];
                
                NSNumber *availableBikes = results[@"availableBikes"];
                NSNumber *availableDocks = results[@"availableDocks"];
                
                NSNumber *latitude = results[@"latitude"];
                NSNumber *longitude = results[@"longitude"];
                bikeShareLocation.coordinate = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
                
                // additional location information
                bikeShareLocation.totalDocks = results[@"totalDocks"];
                bikeShareLocation.availableDocks = results[@"availableDocks"];
                bikeShareLocation.availableBikes = results[@"availableBikes"];
                bikeShareLocation.stationName = results[@"stationName"];
                
                // now that availableBikes has a value I can use it in my string below
                bikeShareLocation.subtitle = [NSString stringWithFormat:@"Available Bikes: %@, Available Docks: %@",[availableBikes stringValue],[availableDocks stringValue]];
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
