//
//  PVPostsViewController.h
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import <UIKit/UIKit.h>
#import "PVPostsTableViewCell.h"
#import "PVSocketConnection.h"
#import "SocketIO.h"
#import "CustomIOS7AlertView.h"
#import "PVSingletonData.h"
#import "PVReplyTableViewController.h"
#import "PVPortalPageViewController.h"
#import "PVPortfileViewController.h"
#import "PVMenuNavigationViewController.h"
#import "PVEmptyListTableViewCell.h"
#import "PVCoreLocationController.h"
@class PVLoginViewController;

@interface PVPostsViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, SocketIOConnectionDelegate, CustomIOS7AlertViewDelegate>
{
    NSMutableArray *postVibes;
    UIBarButtonItem *newVibe;
    UIBarButtonItem *search;
}
@property (nonatomic, strong) PVLoginViewController *loginViewController;
@property (nonatomic, strong) PVPostsTableViewCell *postsCell;
@property (nonatomic, weak) PVEmptyListTableViewCell *emptyListCell;
@property (strong, nonatomic) PVSocketConnection *socketConnection;
@property (nonatomic, strong) PVReplyTableViewController *replyTableView;
@property (nonatomic, strong) UITableView *replyTable;
@property (strong, nonatomic) PVPortalPageViewController *portalPageViewController;
@property (strong, nonatomic) PVPortfileViewController *portfileViewController;
-(void)getVibes;
@end