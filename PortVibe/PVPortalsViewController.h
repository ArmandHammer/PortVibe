//
//  PVPortalsViewController.h
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import <UIKit/UIKit.h>
#import "PVPortalsTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "PVSocketConnection.h"
#import "SocketIO.h"
#import "PVMenuNavigationViewController.h"
#import "PVSingletonData.h"
#import "PVEmptyListTableViewCell.h"
@class PVPortalPageViewController;
@class PVMapviewViewController;

@interface PVPortalsViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, SocketIOConnectionDelegate>
{
    NSMutableArray *portals;
    UIBarButtonItem *search;
}

@property (strong, nonatomic) PVMapviewViewController *mapviewViewController;
@property (weak, nonatomic) PVEmptyListTableViewCell *emptyCell;
@property (strong, nonatomic) PVPortalsTableViewCell *portalCell;
@property (weak, nonatomic) PVEmptyListTableViewCell *emptyListCell;
@property (strong, nonatomic) PVSocketConnection *socketConnection;
@property (strong, nonatomic) PVPortalPageViewController *portalPageViewController;
@end