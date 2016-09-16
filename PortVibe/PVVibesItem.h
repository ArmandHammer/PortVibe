//
//  PVVibesItem.h
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import <Foundation/Foundation.h>

@interface PVVibesItem : NSObject

@property (strong, nonatomic) NSString *vibeID;
@property (strong, nonatomic) NSString *vibeMessage;
@property (strong, nonatomic) NSString *vibePortalLink;
@property (strong, nonatomic) NSString *vibePortalID;
@property (strong, nonatomic) NSString *vibePortalName;
@property (strong, nonatomic) NSString *vibeTime;
@property (strong, nonatomic) NSString *vibeAuthor;
@property (strong, nonatomic) NSString *vibeUpvotes;
@property (strong, nonatomic) NSString *vibeReplies;
@property (strong, nonatomic) NSString *vibeFlags;
@property (strong, nonatomic) NSString *vibeCountry;
@property (strong, nonatomic) NSString *vibeAdministrative;
@property (strong, nonatomic) NSString *vibeLocality;

@end