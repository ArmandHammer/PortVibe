//
//  PVPortInTableViewCell.m
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import "PVPortInTableViewCell.h"

@implementation PVPortInTableViewCell
@synthesize displayName, portalName, userPhoto, portalPhoto, portTime;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        portTime.text = nil;
        [displayName setTitle:nil forState:UIControlStateNormal];
        [portalName setTitle:nil forState:UIControlStateNormal];
    }
    return self;
}

@end