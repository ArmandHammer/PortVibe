//
//  PVPortfileViewController.h
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"
#import "PVSingletonData.h"
#import "PVMenuNavigationViewController.h"

@interface PVPortfileViewController : UIViewController <CustomIOS7AlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UIButton *addFriend;
@property (strong, nonatomic) IBOutlet UIButton *reportUser;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *userDescription;
@property (strong, nonatomic) IBOutlet UILabel *userRep;
@end
