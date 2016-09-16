//
//  PVReplyTableViewCell.m
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import "PVReplyTableViewCell.h"

@implementation PVReplyTableViewCell
@synthesize userComment, userName, userPhoto, userRep, like, dislike, flag, postTime;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        userComment.text = nil;
        postTime.text = nil;
        [userName setTitle:nil forState:UIControlStateNormal];
    }
    return self;
}

@end