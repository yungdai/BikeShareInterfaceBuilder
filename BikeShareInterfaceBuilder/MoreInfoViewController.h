//
//  MoreInfoViewController.h
//  BikeShareInterfaceBuilder
//
//  Created by Yung Dai on 2015-05-08.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "BikeShareLocation.h"
#import "BikeShareLocationManager.h"
#import "HTTPCommunication.h"
#import "MoreInfoViewController.h"

// check to see if the iOS is 8.0 or higher
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface MoreInfoViewController : UIViewController
@property (strong, nonatomic) id<MKAnnotation> bikeStationData;
@property (strong, nonatomic) NSString *string;
@property (strong, nonatomic) IBOutlet UILabel *moreInformationLabel;
@property (strong, nonatomic) IBOutlet UILabel *stationName;
@property (strong, nonatomic) IBOutlet UILabel *availableBikes;
@property (strong, nonatomic) IBOutlet UILabel *availableDocks;
@property (strong, nonatomic) IBOutlet UILabel *totalDocks;


// map properties
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) BikeShareLocationManager *bikeLocationManager;
@property (strong, nonatomic) IBOutlet UIButton *guideMeButton;
@property MKRoute *routeToStation;


@end
