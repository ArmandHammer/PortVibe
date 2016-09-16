//
//  PVGPSCellTableViewCell.h
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import <UIKit/UIKit.h>

@interface PVGPSCellTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UISwitch *gpsSwitch;
@property (strong, nonatomic) IBOutlet UILabel *gpsLabel;

@end
