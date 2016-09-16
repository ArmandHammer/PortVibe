//
//  PVReplyTableViewController.h
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import <UIKit/UIKit.h>
#import "PVReplyTableViewCell.h"

@interface PVReplyTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *displayName;
    NSArray *mainArray;
    NSArray *userTime;
}

@property (nonatomic, strong) PVReplyTableViewCell *replyCell;
@end
