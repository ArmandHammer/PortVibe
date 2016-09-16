//
//  PVAccountSettingsViewController.h
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"
@class PVAppDelegate;

@interface PVAccountSettingsViewController : UIViewController <CustomIOS7AlertViewDelegate>
{
    NSURLConnection *connection;
    NSMutableData *receivedData;
    int _button;
    NSString *verifyPassword;
    NSString *oldEmail;
    NSString *newEmail;
    NSString *newDisplayName;
}

- (IBAction)changePassword:(id)sender;
- (IBAction)changeEmail:(id)sender;
- (IBAction)changeDisplayName:(id)sender;

@end
