//
//  PVAppDelegate.h
//  PortVibe
//
//  Created by Mark Gorys on -05-1814.
//  Copyright (c) 2014 Armand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PVAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
