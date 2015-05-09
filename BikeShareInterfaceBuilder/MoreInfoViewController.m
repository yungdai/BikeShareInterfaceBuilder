//
//  MoreInfoViewController.m
//  BikeShareInterfaceBuilder
//
//  Created by Yung Dai on 2015-05-08.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//

#import "MoreInfoViewController.h"

@interface MoreInfoViewController ()

@end

@implementation MoreInfoViewController

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
    
    
    [self.locationManager startUpdatingLocation];
    
    
    [self.mapView addAnnotation:self.bikeStationData];
    //  plot the location of all the bikeShareLocations

    
 
    // sets the view controller to be the delegate for the MapView
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
    
    

    
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
            bikeShareAnnotation.leftCalloutAccessoryView.backgroundColor = [UIColor greenColor];
            
            
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


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // get the bike station BikeStationLocation Object and assigned it the bikeStationData
    BikeShareLocation *bikeShareLocationInfo = (BikeShareLocation *)self.bikeStationData;
    NSString *stationName = bikeShareLocationInfo.stationName;
    NSNumber *availableBikes = bikeShareLocationInfo.availableBikes;
    NSNumber *availableDocks = bikeShareLocationInfo.availableDocks;
    NSNumber *totalDocks = bikeShareLocationInfo.totalDocks;
    self.stationName.text = [NSString stringWithFormat:
                                      @"Bike Station Name: %@", stationName];
    self.availableBikes.text = [NSString stringWithFormat:
                                      @"Available Bikes: %@", availableBikes];
    self.availableDocks.text = [NSString stringWithFormat:
                                      @"Available Docks: %@",availableDocks];
    self.totalDocks.text = [NSString stringWithFormat:
                                      @"TotalDocks: %@", totalDocks];
}



- (IBAction)guideMeButtonPressed:(id)sender {
    
    id <MKAnnotation> annotation = self.bikeStationData;
    CLLocationCoordinate2D coordinate = [annotation coordinate];
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
    MKMapItem *mapitem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapitem.name = annotation.title;
    NSDictionary *mapLaunchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking};
    [mapitem openInMapsWithLaunchOptions:mapLaunchOptions];
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
