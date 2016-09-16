//
//  PVLoginViewController.h
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import <UIKit/UIKit.h>
#import "SFHFKeychainUtils.h"
#import "PVSingletonData.h"
@class PVAppDelegate;

@interface PVLoginViewController : UIViewController <UITextFieldDelegate>
{
    NSString *userEmail;
    NSString *userPassword;
    NSString *updateExistingVal;
    NSString *userID;
}
-(void)loginConnection;
-(void)getUserInfo;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *email;

- (IBAction)loginButton:(id)sender;
@end