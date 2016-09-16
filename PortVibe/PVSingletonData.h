//
//  PVSingletonData.h
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import <Foundation/Foundation.h>

@interface PVSingletonData : NSObject

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *portfileID;
@property (nonatomic, strong) NSString *replyID;
@property (nonatomic, strong) NSNumber *rep;
@property (nonatomic, strong) NSString *gpsLabel;
@property (nonatomic, strong) NSString *userDisplayName;
@property (nonatomic, strong) NSString *userEmail;
@property (nonatomic, strong) NSMutableArray *likedPosts;
@property (nonatomic, strong) UISwitch *gps;
@property BOOL isLoggedIn;
@property (nonatomic, strong) NSMutableArray *userFriends;
@property (nonatomic, strong) NSMutableArray *userPortals;
@property (nonatomic, strong) NSMutableArray *userActivity;
@property (nonatomic, strong) NSMutableArray *userHome;
@property (nonatomic, strong) NSMutableArray *userVibes;
@property (nonatomic, strong) NSMutableArray *portalsNearUser;

+(PVSingletonData *)sharedID; //class method returns singleton object
-(void)resetValues;  //resets the values

@end
