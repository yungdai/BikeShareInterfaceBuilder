//
//  ViewController.h
//  BikeShareInterfaceBuilder
//
//  Created by Yung Dai on 2015-05-08.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "BikeShareLocationManager.h"
#import "MoreInfoViewController.h"

// check to see if the iOS is 8.0 or higher
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface MapViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) BikeShareLocationManager *bikeLocationManager;
@property MKRoute *routeToStation;
@property (strong, nonatomic) IBOutlet UIButton *closestButton;
@property CLLocation *currentLocation;


@end
