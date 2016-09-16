//
//  PVCoreLocationController.m
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import "PVCoreLocationController.h"

@implementation PVCoreLocationController
@synthesize locationManager, delegate;
//static PVCoreLocationController *shared = NULL;

- (id)init
{
    self = [super init];
	if(self != nil)
    {
        if([CLLocationManager locationServicesEnabled])
        {
            if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted )
            {
                // Create and show an alert view with this error displayed
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Detetecting Your location"
                                                             message:@"Location services are enabled but restricted."
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
                [av show];
            }
            else
            {
                locationManager=[[CLLocationManager alloc] init];
                locationManager.delegate=self;
                locationManager.desiredAccuracy=kCLLocationAccuracyBest;
                locationManager.distanceFilter=10;
                [locationManager startUpdatingLocation];
            }
        }
        else
        {
            // Create and show an alert view with this error displayed
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Detetecting Your Location"
                                                         message:@"Location services are disabled."
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
            [av show];
        }
	}
	return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    CLLocation *oldLocation;
    
    if (locations.count >= 2)
    {
        oldLocation = [locations objectAtIndex:locations.count-1];
    }
    else
    {
        oldLocation = nil;
    }
    
    //get the distance in meters
    CLLocationDistance meters = [newLocation distanceFromLocation:oldLocation];
    if (meters >= 10 )
    {
        [self.delegate locationUpdate:newLocation];
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self.delegate locationError:error];
}

@end