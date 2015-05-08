//
//  MapViewController.h
//  BikeShareInterfaceBuilder
//
//  Created by Yung Dai on 2015-05-06.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BikeShareLocation.h"
#import "BikeShareLocationManager.h"
#import "HTTPCommunication.h"
#import "BikeStationMKMapView.h"


// check to see if the iOS is 8.0 or higher
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface MapViewController : UITabBarController<MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) BikeShareLocationManager *bikeLocationManager;

@end
