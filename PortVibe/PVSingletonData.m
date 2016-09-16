//
//  PVSingletonData.m
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import "PVSingletonData.h"

@implementation PVSingletonData

static PVSingletonData *sharedID = nil; //static instance variable

+(PVSingletonData *)sharedID
{
    if(sharedID == nil)
    {
        sharedID = [[super allocWithZone:NULL] init];
    }
    return sharedID;
}

+(id)allocWithZone:(NSZone *)zone //ensure singleton status
{
    return [self sharedID];
}

-(id)copyWithZone:(NSZone *)zone //ensure singleton status
{
    return self;
}

-(void)resetValues //used to reset all the values
{
    _replyID = nil;
    _userFriends = nil;
    _userID = nil;
    _userPortals = nil;
    _portalsNearUser = nil;
    _userActivity = nil;
    _userVibes = nil;
    _userHome = nil;
    _isLoggedIn = NO;
    sharedID = nil;
    _rep = nil;
    _likedPosts = nil;
}

@end
