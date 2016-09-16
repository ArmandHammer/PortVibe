//
//  PVPostsTableViewCell.h
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import <UIKit/UIKit.h>

@interface PVPostsTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *userPhoto;
@property (strong, nonatomic) IBOutlet UILabel *userComment;
@property (strong, nonatomic) IBOutlet UIButton *displayName;
@property (strong, nonatomic) IBOutlet UIButton *portalName;
@property (strong, nonatomic) IBOutlet UIButton *like;
@property (strong, nonatomic) IBOutlet UIButton *reply;
@property (strong, nonatomic) IBOutlet UIButton *report;
@property (strong, nonatomic) IBOutlet UIButton *deletePost;
@property (strong, nonatomic) IBOutlet UILabel *userRep;
@property (strong, nonatomic) IBOutlet UIImageView *distanceImage;
@property (strong, nonatomic) IBOutlet UILabel *postDistance;
@property (strong, nonatomic) IBOutlet UILabel *postTime;

@end
