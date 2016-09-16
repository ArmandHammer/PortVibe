//
//  PVPortalPageViewController.h
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import <UIKit/UIKit.h>
#import "PVPostsTableViewCell.h"
#import "CustomIOS7AlertView.h"
#import "PVReplyTableViewController.h"
#import "PVPortalPageViewController.h"
#import "PVMenuNavigationViewController.h"
#import "PVPortfileViewController.h"
#import "PVSingletonData.h"

@interface PVPortalPageViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CustomIOS7AlertViewDelegate>
{
    NSArray *displayNames;
    NSArray *friendsBlurb;
    NSArray *userTime;
}

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *portalDescription;
@property (strong, nonatomic) IBOutlet UILabel *announcement;
@property (strong, nonatomic) IBOutlet UILabel *portalName;
@property (strong, nonatomic) IBOutlet UILabel *subscribers;
@property (strong, nonatomic) IBOutlet UILabel *currentPortIn;
@property (strong, nonatomic) IBOutlet UIButton *announcementButton;
@property (strong, nonatomic) IBOutlet UIButton *portalDescriptionButton;
@property (strong, nonatomic) IBOutlet UIImageView *portalImage;
@property (nonatomic, strong) PVReplyTableViewController *replyTableView;
@property (nonatomic, strong) UITableView *replyTable;
@property (strong, nonatomic) PVPostsTableViewCell *postsCell;
@property (strong, nonatomic) PVPortfileViewController *portfileViewController;
@end