//
//  PVPortalsTableViewCell.h
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import <UIKit/UIKit.h>

@interface PVPortalsTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *portalImage;
@property (nonatomic, strong) IBOutlet UILabel *portalDescription;
@property (nonatomic, strong) IBOutlet UIButton *portalName;
@property (nonatomic, strong) IBOutlet UIButton *portIn;

@end