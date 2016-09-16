//
//  PVMapviewViewController.m
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import "PVMapviewViewController.h"

@implementation PVMapviewViewController
@synthesize mapView, locationController, userCoordinates, currentLocation;
int _circleType = 0;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self.navigationItem setTitle:@"MapView"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mapView.showsUserLocation = YES;
    mapView.delegate = self;
    mapView.zoomEnabled = NO;
    mapView.scrollEnabled = NO;
}

-(void)viewDidAppear:(BOOL)animated
{
    //singleton data
    PVSingletonData *singletonData = [PVSingletonData sharedID];
    if (singletonData.isLoggedIn)
    {
        newPortal = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"portalPic.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(newPortal)];
        self.navigationItem.rightBarButtonItem = newPortal;
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString* AnnotationIdentifier = @"Annotation";
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
    
    if (!pinView)
    {
        MKPinAnnotationView *customPinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
        
        if (annotation == self.mapView.userLocation)
            customPinView.image = [UIImage imageNamed:@"portViber.png"];
        
        customPinView.animatesDrop = NO;
        customPinView.canShowCallout = YES;
        //pinView.centerOffset = CGPointMake(0, 30);
        return customPinView;
    }
    else
    {
        pinView.annotation = annotation;
    }
    return pinView;
}

-(void)newPortal
{
    //generate a brand new portal
    CLLocationCoordinate2D center = {currentLocation.coordinate.latitude, currentLocation.coordinate.longitude};
    if (_circleType == 0)
    {
        MKCircle *circle = [MKCircle circleWithCenterCoordinate:center radius:70];
        [mapView addOverlay:circle];
        _circleType = 1;
    }
    else if (_circleType == 1)
    {
        MKCircle *circle = [MKCircle circleWithCenterCoordinate:center radius:45];
        [mapView addOverlay:circle];
        _circleType = 2;
    }
    else if (_circleType == 2)
    {
        MKCircle *circle = [MKCircle circleWithCenterCoordinate:center radius:100];
        [mapView addOverlay:circle];
    }
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    if (_circleType == 0)
    {
        MKCircleView *circleView = [[MKCircleView alloc] initWithOverlay:overlay];
        [circleView setFillColor:[UIColor blueColor]];
        [circleView setAlpha:0.2f];
        return circleView;
    }
    else if (_circleType == 1)
    {
        MKCircleView *circleView = [[MKCircleView alloc] initWithOverlay:overlay];
        [circleView setFillColor:[UIColor redColor]];
        [circleView setAlpha:0.2f];
        return circleView;
    }
    
    MKCircleView *circleView = [[MKCircleView alloc] initWithOverlay:overlay];
    [circleView setFillColor:[UIColor greenColor]];
    [circleView setAlpha:0.2f];
    return circleView;
}

- (void)mapView:(MKMapView *)myMapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    myMapView.showsUserLocation = YES;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([userLocation coordinate], 500, 750);
    [myMapView setRegion:region animated:YES];
    [userCoordinates setText:([NSString stringWithFormat: @"latitude %+.8f, longitude %+.8f\n",
          userLocation.coordinate.latitude,
          userLocation.coordinate.longitude])];
    currentLocation = userLocation;
}

- (void)locationError:(NSError *)error
{
    self.userCoordinates.text = [error description];
}

@end
