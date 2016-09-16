//
//  PVRegisterViewController.h
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import <UIKit/UIKit.h>
@class PVAppDelegate;

@interface PVRegisterViewController : UIViewController <UITextFieldDelegate>
{
    NSURLConnection *connection;
    NSMutableData *receivedData;
}
@property (strong, nonatomic) IBOutlet UITextField *displayName;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *retypePassword;
- (IBAction)registerButton:(id)sender;

@end