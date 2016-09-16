//
//  PVPortalsTableViewCell.m
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import "PVPortalsTableViewCell.h"

@implementation PVPortalsTableViewCell
@synthesize portalDescription, portalName, portalImage, portIn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        portalDescription.text = nil;
        [portalName setTitle:nil forState:UIControlStateNormal];
    }
    return self;
}

@end