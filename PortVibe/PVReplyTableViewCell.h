//
//  PVReplyTableViewCell.h
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import <UIKit/UIKit.h>

@interface PVReplyTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *like;
@property (strong, nonatomic) IBOutlet UIButton *dislike;
@property (strong, nonatomic) IBOutlet UIButton *flag;
@property (strong, nonatomic) IBOutlet UIButton *userName;
@property (strong, nonatomic) IBOutlet UILabel *userRep;
@property (strong, nonatomic) IBOutlet UILabel *userComment;
@property (strong, nonatomic) IBOutlet UILabel *postTime;
@property (strong, nonatomic) IBOutlet UIImageView *userPhoto;

@end