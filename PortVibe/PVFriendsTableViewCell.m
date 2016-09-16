//
//  PVFriendsTableViewCell.m
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import "PVFriendsTableViewCell.h"

@implementation PVFriendsTableViewCell
@synthesize userPhoto, userRep, userBlurb, displayName, message, unfriend;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        userBlurb.text = nil;
        [displayName setTitle:nil forState:UIControlStateNormal];
    }
    return self;
}

@end
