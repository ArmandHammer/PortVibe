//
//  PVFriendsTableViewCell.h
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import <UIKit/UIKit.h>

@interface PVFriendsTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *displayName;
@property (strong, nonatomic) IBOutlet UIButton *unfriend;
@property (strong, nonatomic) IBOutlet UIButton *message;
@property (strong, nonatomic) IBOutlet UILabel *userBlurb;
@property (strong, nonatomic) IBOutlet UIImageView *userPhoto;
@property (strong, nonatomic) IBOutlet UILabel *userRep;

@end