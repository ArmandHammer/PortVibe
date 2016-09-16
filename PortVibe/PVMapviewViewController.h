//
//  PVMapviewViewController.h
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "PVCoreLocationController.h"
#import "PVSingletonData.h"

@interface PVMapviewViewController : UIViewController <MKMapViewDelegate, CoreLocationControllerDelegate>
{
    UIBarButtonItem *newPortal;
}
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *NW;
@property (weak, nonatomic) IBOutlet UILabel *NE;
@property (weak, nonatomic) IBOutlet UILabel *SW;
@property (weak, nonatomic) IBOutlet UILabel *SE;
@property (weak, nonatomic) IBOutlet UILabel *userCoordinates;
@property (weak, nonatomic) MKUserLocation *currentLocation;
@property (nonatomic, retain) PVCoreLocationController *locationController;
@end