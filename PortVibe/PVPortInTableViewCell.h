//
//  PVPortInTableViewCell.h
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import <UIKit/UIKit.h>

@interface PVPortInTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *displayName;
@property (strong, nonatomic) IBOutlet UIButton *portalName;
@property (strong, nonatomic) IBOutlet UIImageView *userPhoto;
@property (strong, nonatomic) IBOutlet UIImageView *portalPhoto;
@property (strong, nonatomic) IBOutlet UILabel *portTime;

@end
