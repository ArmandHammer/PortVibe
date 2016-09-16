//
//  PVPostsTableViewCell.m
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import "PVPostsTableViewCell.h"

@implementation PVPostsTableViewCell
@synthesize userComment, displayName, distanceImage, userPhoto, postDistance, userRep, postTime, like, reply, report, portalName, deletePost;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        userComment.text = nil;
        postDistance.text = nil;
        postTime.text = nil;
        [displayName setTitle:nil forState:UIControlStateNormal];
        [portalName setTitle:nil forState:UIControlStateNormal];
    }
    return self;
}

@end