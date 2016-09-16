//
//  PVMenuTableViewController.h
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import "PVSingletonData.h"
#import "PVHomeViewController.h"
#import "PVPostsViewController.h"
#import "PVMyPortfolioViewController.h"
#import "PVPortalPageViewController.h"
#import "PVPortalsViewController.h"
#import "PVMenuNavigationViewController.h"
#import "PVLoginViewController.h"
#import "PVRegisterViewController.h"
#import "PVForgotPasswordViewController.h"
#import "PVGPSCellTableViewCell.h"
#import "PVAccountSettingsViewController.h"
#import "UIViewController+REFrostedViewController.h"
@class PVAppDelegate;

@interface PVMenuTableViewController : UITableViewController <UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSArray *menuItems;
    UILabel *repLabel;
    UILabel *userName;
    UIImageView *badge1;
    UIImageView *badge2;
    UIImageView *badge3;
    UIImageView *imageView;
}
@property (strong, nonatomic) PVGPSCellTableViewCell *gpsTableViewCell;

@end