//
//  PVForgotPasswordViewController.h
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import <UIKit/UIKit.h>
@class PVAppDelegate;

@interface PVForgotPasswordViewController : UIViewController
{
    NSURLConnection *connection;
    NSMutableData *receivedData;
}

@property (strong, nonatomic) IBOutlet UITextField *email;
-(IBAction)sendButton:(id)sender;
@end
