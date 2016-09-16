//
//  PVAppDelegate.m
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import "PVAppDelegate.h"
static NSString *serviceName = @"PortVibe";

@implementation PVAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize portalsViewController, postsViewController, homeViewController, myPortfolioViewController, loginViewController, registerViewController, mapviewViewController, forgotPasswordViewController, socketConnection, portalPageViewController, locationManager, portfileViewController, frostedViewController, viewControllers, tabBarController, menuTableViewController;

-(void)receivedPacket:(id)packet
{
    NSLog(@"Receiving packets...");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //singleton data
    PVSingletonData *singletonData = [PVSingletonData sharedID];
    
    //create the view controllers array that holds the four tabs: Vibes, Posts, Portfiles, Portals
    viewControllers = [[NSMutableArray alloc] init];
    
    //generate all view controllers
    homeViewController = [[PVHomeViewController alloc] initWithStyle:UITableViewStylePlain];
    postsViewController = [[PVPostsViewController alloc] initWithStyle:UITableViewStylePlain];
    myPortfolioViewController = [[PVMyPortfolioViewController alloc] init];
    portalsViewController = [[PVPortalsViewController alloc] initWithStyle:UITableViewStylePlain];
    loginViewController = [[PVLoginViewController alloc] init];
    registerViewController = [[PVRegisterViewController alloc] init];
    forgotPasswordViewController = [[PVForgotPasswordViewController alloc] init];
    mapviewViewController = [[PVMapviewViewController alloc] init];
    portalPageViewController = [[PVPortalPageViewController alloc] init];
    portfileViewController = [[PVPortfileViewController alloc] init];
    
    //navigation controllers for all tabs
    PVMenuNavigationViewController *homeNavigationController = [[PVMenuNavigationViewController alloc] initWithRootViewController:homeViewController];
    [viewControllers addObject:homeNavigationController];
    
    PVMenuNavigationViewController *postsNavigationController = [[PVMenuNavigationViewController alloc] initWithRootViewController:postsViewController];
    [viewControllers addObject:postsNavigationController];
    
    PVMenuNavigationViewController *portalsNavigationController = [[PVMenuNavigationViewController alloc] initWithRootViewController:portalsViewController];
    [viewControllers addObject:portalsNavigationController];
    
    PVMenuNavigationViewController *myPortfolioNavigationController = [[PVMenuNavigationViewController alloc] initWithRootViewController:myPortfolioViewController];
    [viewControllers addObject:myPortfolioNavigationController];
    
    menuTableViewController = [[PVMenuTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    //set the transition controllers
    [postsViewController setLoginViewController:loginViewController];
    [portalsViewController setMapviewViewController:mapviewViewController];
    [homeViewController setPortalPageViewController:portalPageViewController];
    [postsViewController setPortalPageViewController:portalPageViewController];
    [portalsViewController setPortalPageViewController:portalPageViewController];
    [myPortfolioViewController setPortalPageViewController:portalPageViewController];
    [homeViewController setPortfileViewController:portfileViewController];
    [postsViewController setPortfileViewController:portfileViewController];
    [myPortfolioViewController setPortfileViewController:portfileViewController];
    [portalPageViewController setPortfileViewController:portfileViewController];
    
    //create tab bar controller and add viewControllers to it
    tabBarController = [[UITabBarController alloc] init];
    [tabBarController setViewControllers:viewControllers];
    
    // Create frosted view controller for each tab
    frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:tabBarController menuViewController:menuTableViewController];
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    frostedViewController.liveBlur = YES;
    frostedViewController.delegate = self;
    
    // user is not logged in
    if (!singletonData.isLoggedIn)
    {
        [[[[tabBarController tabBar]items]objectAtIndex:0]setEnabled:FALSE];
        [[[[tabBarController tabBar]items]objectAtIndex:3]setEnabled:FALSE];
        [tabBarController setSelectedIndex:1];
    }
    else
    {
        [[[[tabBarController tabBar]items]objectAtIndex:0]setEnabled:TRUE];
        [[[[tabBarController tabBar]items]objectAtIndex:3]setEnabled:TRUE];
        [tabBarController setSelectedIndex:0];
    }
    
    [self.window setRootViewController:frostedViewController];
    [self.window makeKeyAndVisible];
    
    //socket connection
    socketConnection = [PVSocketConnection sharedSingleton];
    socketConnection.delegate = self;
    
    return YES;
}

- (BOOL)authenticateUser
{
    //singleton data
    PVSingletonData *singletonData = [PVSingletonData sharedID];
    NSError *error = nil;
    userEmail = singletonData.userEmail;
    userPassword = [SFHFKeychainUtils getPasswordForUsername:userEmail andServiceName:serviceName error:&error];
    return YES;
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer
{
    
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController");
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didShowMenuViewController");
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willHideMenuViewController");
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didHideMenuViewController");
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"PortVibe" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"PortVibe.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
