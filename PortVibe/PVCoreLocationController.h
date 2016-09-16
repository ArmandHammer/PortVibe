//
//  PVCoreLocationController.h
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"

@protocol CoreLocationControllerDelegate <NSObject>
- (void)locationUpdate:(CLLocation *)location;
- (void)locationError:(NSError *)error;
@end


@interface PVCoreLocationController : NSObject <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    id delegate;
}

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) id <CoreLocationControllerDelegate> delegate;
//+(PVCoreLocationController *)sharedLocationSingleton; //class method returns singleton object

@end