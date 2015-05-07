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
// title will be equal to the stationName
@property (nonatomic, readwrite, copy) NSString *title;
// subtitle will be equal to the availablebikes
@property (nonatomic, readwrite, copy) NSString *subtitle;


@end
