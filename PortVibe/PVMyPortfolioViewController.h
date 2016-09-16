//
//  PVMyPortfolioViewController.h
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import <UIKit/UIKit.h>
#import "PVPostsTableViewCell.h"
#import "PVFriendsTableViewCell.h"
#import "PVPortalsTableViewCell.h"
#import "PVSocketConnection.h"
#import "SocketIO.h"
#import "CustomIOS7AlertView.h"
#import "PVReplyTableViewController.h"
#import "PVPortalPageViewController.h"
#import "PVPortfileViewController.h"
#import "PVSingletonData.h"
#import "PVMenuNavigationViewController.h"
#import "PVEmptyListTableViewCell.h"

@interface PVMyPortfolioViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, SocketIOConnectionDelegate, CustomIOS7AlertViewDelegate, UIAlertViewDelegate>
{
    NSMutableArray *activity;
    NSMutableArray *friends;
    NSMutableArray *portals;
    UIBarButtonItem *newVibe;
    UIBarButtonItem *search;
    int _alert;
    int _cellTag;
}

@property (strong, nonatomic) PVPostsTableViewCell *postsCell;
@property (strong, nonatomic) PVFriendsTableViewCell *friendsCell;
@property (strong, nonatomic) PVPortalsTableViewCell *portalCell;
@property (strong, nonatomic) PVEmptyListTableViewCell *emptyListCell;
@property (strong, nonatomic) PVSocketConnection *socketConnection;
@property (strong, nonatomic) UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *displayName;
@property (weak, nonatomic) IBOutlet UILabel *userBlurb;
@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;
@property (strong, nonatomic) IBOutlet UIButton *userBlurbButton;
@property (weak, nonatomic) IBOutlet UILabel *userRep;

@property (strong, nonatomic) UITextView *descriptionTextView;
@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, strong) PVReplyTableViewController *replyTableView;
@property (nonatomic, strong) UITableView *replyTable;
@property (strong, nonatomic) PVPortalPageViewController *portalPageViewController;
@property (strong, nonatomic) PVPortfileViewController *portfileViewController;
- (IBAction)segmentedControlIndexChanged;
- (IBAction)descriptionButtonPressed:(id)sender;
- (IBAction)photoButtonPressed:(id)sender;

@end
