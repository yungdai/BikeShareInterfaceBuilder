//
//  BikeShareLocation.h
//  BikeShareInterfaceBuilder
//
//  Created by Yung Dai on 2015-05-06.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BikeShareLocation : NSObject <MKAnnotation>

// Center latitude and longitude of the annotation view.
// The implementation of this property must be KVO compliant.
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;


// this two optional properties set the CallOut title/subtitle
@property (nonatomic, readwrite, copy) NSString *title;
@property (nonatomic, readwrite, copy) NSString *subtitle;

// additional information about the bike share location
@property (nonatomic, readwrite, copy) NSNumber *availableDocks;
@property (nonatomic, readwrite, copy) NSNumber *totalDocks;
@property (nonatomic, readwrite, copy) NSNumber *availableBikes;
@property (nonatomic, readwrite, copy) NSString *stationName;

// will store the distance of the station from the user
@property (nonatomic, readwrite) CLLocationDistance *distanceFromUser;
@property (nonatomic, readwrite) CLLocation *bikeSharelocation;

@end
