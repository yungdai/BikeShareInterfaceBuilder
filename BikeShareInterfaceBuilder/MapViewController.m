//
//  ViewController.m
//  BikeShareInterfaceBuilder
//
//  Created by Yung Dai on 2015-05-08.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bikeLocationManager = [[BikeShareLocationManager alloc]init];
    
    
    // user location setup
    self.locationManager = [[CLLocationManager alloc]init];
    
    // make sure that the user is using iOS 8 or later
    
    if(IS_OS_8_OR_LATER) {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
        
    }
    
    self.locationManager.distanceFilter = kCLLocationAccuracyKilometer;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    
    //  plot the location of all the bikeShareLocations
    [self.bikeLocationManager getBikeShareLocationsOnSucess:^(NSArray *locations) {
        
        for (BikeShareLocation *location in locations)
        {
            
            [self.mapView addAnnotation:location];
        }
        
    }];
    
    
    [self.locationManager startUpdatingLocation];

    // sets the view controller to be the delegate for the MapView
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.closestButton];
    
    
}

- (IBAction)closestButtonPressed:(id)sender {
    
}


// when I tap the callout accessory I launch the maps app for that location
// mapView:annotationView:calloutAccessoryControlTapped: is called when the user taps on left & right callout accessory UIControls

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [mapView removeOverlay:self.routeToStation.polyline];
    id <MKAnnotation> annotation = view.annotation;
    CLLocationCoordinate2D coordinate = [annotation coordinate];
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
    MKMapItem *mapitem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapitem.name = annotation.title;
    
    if (control == view.rightCalloutAccessoryView) {
        
        MoreInfoViewController *moreInfoViewController = self.tabBarController.viewControllers[1];
        
        moreInfoViewController.bikeStationData = annotation;
        moreInfoViewController.string = annotation.title;
        
        [self.tabBarController setSelectedIndex:1];
        
        
        
    }
    
}

// look at this example http://stackoverflow.com/questions/14061265/list-of-closest-annotations-in-mapkit

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
//    
//    self.currentLocation = [[CLLocation alloc]initWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
//    
//    [self.bikeLocationManager getBikeShareLocationsOnSucess:^(NSArray *locations) {
//        
//        [self.sortedBikeStations addObjectsFromArray:locations];
//        BikeShareLocation *bikeShareLocation = [[BikeShareLocation alloc]init];
//        for (BikeShareLocation *location in locations)
//        {
//            for (int i = 0; i < self.sortedBikeStations.count; i++) {
//                bikeShareLocation = [self.sortedBikeStations objectAtIndex:i];
//                bikeShareLocation.distanceFromUser = [self.currentLocation distanceFromLocation:bikeShareLocation.biekShareLocation];
//            }
//            [self.mapView addAnnotation:location];
//        }
//        NSSortDescriptor *sorter = [[NSSortDescriptor alloc]initWithKey:@"distanceFromUser" ascending:YES];
//        [locations sortedArrayUsingSelector:sorter];
//    }];
}

// method to zoom to the current user location
/* Tells the delegate that one or more annotation views were added to the map.
 By the time this method is called, the specified views are already added to the map
 */
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MKAnnotationView *annotationView = [views objectAtIndex:0];
    id<MKAnnotation> mapPoint = [annotationView annotation];
    
    if (mapPoint == mapView.userLocation) {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mapPoint coordinate] ,700 , 700);
        [mapView setRegion:region animated:YES];
    }
}

// when you select a station it will route a green line to that station
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    
    [mapView removeOverlay:self.routeToStation.polyline];
    id <MKAnnotation> annotation = view.annotation;
    CLLocationCoordinate2D coordinate = [annotation coordinate];
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
    MKMapItem *bikeStationLocation = [[MKMapItem alloc] initWithPlacemark:placemark];
    MKDirectionsRequest *routeToBikeStation = [[MKDirectionsRequest alloc]init];
    [routeToBikeStation setSource:[MKMapItem mapItemForCurrentLocation]];
    [routeToBikeStation setDestination:[[MKMapItem alloc]initWithPlacemark:placemark]];
    MKDirections *directions = [[MKDirections alloc]initWithRequest:routeToBikeStation];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (error)
        {
            NSLog(@"There was an error: %@", error.description);
        } else {
            self.routeToStation = response.routes.lastObject;
            [mapView addOverlay:self.routeToStation.polyline];
        }
    }];
    bikeStationLocation.name = annotation.title;
    
}

// this method is setup the render to render the map overlay
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKPolylineRenderer *routeLine = [[MKPolylineRenderer alloc]initWithPolyline:self.routeToStation.polyline];
    routeLine.strokeColor = [UIColor blueColor];
    routeLine.lineWidth = 6;
    return routeLine;
}


// method to set custom annotation images
// Tells the delegate that one or more annotation views were added to the map.
// By the time this method is called EACH time an annocation is created
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *bikeShareAnnotation = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:@"annoView"];
    
    if([annotation isKindOfClass:[BikeShareLocation class]])
    {
        if (bikeShareAnnotation == nil)
        {
            bikeShareAnnotation = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annoView"];
            bikeShareAnnotation.image = [UIImage imageNamed:@"Bike_Share_Toronto_logo"];
            bikeShareAnnotation.frame = CGRectMake(0, 0, 45, 30);

            // Add an image to the left callout.
            UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Bike_Share_Toronto_logo"]];
            iconView.frame = CGRectMake(0, 0, 75, 55);
            bikeShareAnnotation.leftCalloutAccessoryView = iconView;
            bikeShareAnnotation.leftCalloutAccessoryView.backgroundColor = [UIColor blueColor];
    
            
            // on the right of my Callout display a UIButton I want a UIButtonTypeDetailDisclosure type
            bikeShareAnnotation.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            bikeShareAnnotation.canShowCallout = YES;
            
            // if you tap the left callout run an action method called didTapOnImageView
            UITapGestureRecognizer *tapLeftCallOut = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnImageView:)];
            [bikeShareAnnotation.leftCalloutAccessoryView addGestureRecognizer:tapLeftCallOut];
            iconView.userInteractionEnabled = YES;
        }
    }
    return bikeShareAnnotation;
}


//
- (void)didTapOnImageView:(id)sender
{
    id <MKAnnotation> annotation = [self.mapView selectedAnnotations][0];
    CLLocationCoordinate2D coordinate = [annotation coordinate];
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
    MKMapItem *mapitem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapitem.name = annotation.title;
    

    NSDictionary *mapLaunchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking};
    [mapitem openInMapsWithLaunchOptions:mapLaunchOptions];
}



@end
