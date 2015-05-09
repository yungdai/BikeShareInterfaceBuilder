//
//  MoreInfoViewController.h
//  BikeShareInterfaceBuilder
//
//  Created by Yung Dai on 2015-05-08.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BikeShareLocation.h"

@interface MoreInfoViewController : UIViewController
@property (strong, nonatomic) id<MKAnnotation> bikeStationData;
@property (strong, nonatomic) NSString *string;
@property (strong, nonatomic) IBOutlet UILabel *moreInformationLabel;

@end
