//
//  PVHomeViewController.h
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import <UIKit/UIKit.h>
#import "PVPostsTableViewCell.h"
#import "PVPortInTableViewCell.h"
#import "PVSocketConnection.h"
#import "SocketIO.h"
#import "PVEmptyListTableViewCell.h"
#import "CustomIOS7AlertView.h"
@class PVPortalPageViewController;
#import "PVReplyTableViewController.h"
@class PVPortfileViewController;
#import "PVSingletonData.h"
#import "UIViewController+REFrostedViewController.h"
@class PVMenuTableViewController;
@class PVMenuNavigationViewController;

@interface PVHomeViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, SocketIOConnectionDelegate, CustomIOS7AlertViewDelegate>
{
    NSMutableArray *homeVibes;
    UIBarButtonItem *newVibe;
    UIBarButtonItem *search;
}

@property (nonatomic, strong) PVPostsTableViewCell *postsCell;
@property (nonatomic, strong) PVPortInTableViewCell *portCell;
@property (nonatomic, weak) PVEmptyListTableViewCell *emptyListCell;
@property (nonatomic, strong) PVReplyTableViewController *replyTableView;
@property (nonatomic, strong) UITableView *replyTable;
@property (strong, nonatomic) PVSocketConnection *socketConnection;
@property (strong, nonatomic) PVPortalPageViewController *portalPageViewController;
@property (strong, nonatomic) PVPortfileViewController *portfileViewController;
@end