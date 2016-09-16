//
//  PVAppDelegate.h
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import <UIKit/UIKit.h>
#import "PVPostsViewController.h"
#import "PVPortalsViewController.h"
#import "PVHomeViewController.h"
#import "PVMyPortfolioViewController.h"
#import "PVLoginViewController.h"
#import "PVRegisterViewController.h"
#import "PVMapviewViewController.h"
#import "PVForgotPasswordViewController.h"
#import "SocketIO.h"
#import "PVSocketConnection.h"
#import "PVCoreLocationController.h"
#import "PVPortalPageViewController.h"
#import "PVPortfileViewController.h"
#include "REFrostedViewController.h"
#import "PVMenuNavigationViewController.h"
#import "PVMenuTableViewController.h"
#import "PVSingletonData.h"
#import <CoreLocation/CoreLocation.h>

@interface PVAppDelegate : UIResponder <REFrostedViewControllerDelegate, UIApplicationDelegate, CLLocationManagerDelegate, SocketIODelegate, SocketIOConnectionDelegate>
{
    NSDictionary *operatorData;
    NSString *userEmail;
    NSString *userPassword;
}

@property (strong, nonatomic) PVSocketConnection *socketConnection;
@property (strong, nonatomic) PVCoreLocationController *locationManager;
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) PVLoginViewController *loginViewController;
@property (strong, nonatomic) PVPortalPageViewController *portalPageViewController;
@property (strong, nonatomic) PVForgotPasswordViewController *forgotPasswordViewController;
@property (strong, nonatomic) PVRegisterViewController *registerViewController;
@property (strong, nonatomic) PVMyPortfolioViewController *myPortfolioViewController;
@property (strong, nonatomic) PVHomeViewController *homeViewController;
@property (strong, nonatomic) PVPostsViewController *postsViewController;
@property (strong, nonatomic) PVPortalsViewController *portalsViewController;
@property (strong, nonatomic) PVMapviewViewController *mapviewViewController;
@property (strong, nonatomic) PVPortfileViewController *portfileViewController;
@property (strong, nonatomic) PVMenuTableViewController *menuViewController;
@property (strong, nonatomic) PVMenuNavigationViewController *menuNavViewController;
@property (strong, nonatomic) REFrostedViewController *frostedViewController;
@property (strong, nonatomic) NSMutableArray *viewControllers;
@property (readonly, retain, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, retain, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, retain, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) UITabBarController *tabBarController;
@property (strong, nonatomic) PVMenuTableViewController *menuTableViewController;
- (void)saveContext;
- (BOOL)authenticateUser;
- (NSURL *)applicationDocumentsDirectory;

@end
