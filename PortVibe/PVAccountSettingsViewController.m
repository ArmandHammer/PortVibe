//
//  PVAccountSettingsViewController.m
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import "PVAccountSettingsViewController.h"
#import "PVAppDelegate.h"

@implementation PVAccountSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self.navigationItem setTitle:@"Forgot Password"];
        CAGradientLayer *grad = [CAGradientLayer layer];
        grad.frame = self.view.bounds;
        grad.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor] CGColor], (id)[[UIColor whiteColor] CGColor], nil];
        [self.view.layer insertSublayer:grad atIndex:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButton.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(Back)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)Back
{
    PVAppDelegate *appDelegate = (PVAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:appDelegate.tabBarController menuViewController:appDelegate.menuTableViewController];
    
    [appDelegate.window setRootViewController:appDelegate.frostedViewController];
    [appDelegate.window makeKeyAndVisible];
}

-(IBAction)changeDisplayName:(id)sender
{
    _button = 0;
    CustomIOS7AlertView *changeDisplay = [[CustomIOS7AlertView alloc] init];
    [changeDisplay setContainerView:[self createDisplayView]];
    [changeDisplay setButtonTitles:[NSMutableArray arrayWithObjects:@"Cancel", @"Ok", nil]];
    [changeDisplay setUseMotionEffects:TRUE];
    [changeDisplay setDelegate:self];
    [changeDisplay show];
}

- (UIView *)createDisplayView
{
    //create post view, set its background color
    UIView *contentSubView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 125)];
    CAGradientLayer *grad = [CAGradientLayer layer];
    grad.frame = contentSubView.bounds;
    grad.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor] CGColor], (id)[[UIColor whiteColor] CGColor], nil];
    [contentSubView.layer insertSublayer:grad atIndex:0];
    
    //set text fields and label view properties
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 260, 20)];
    UITextField *newNameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 40, 260, 35)];
    newNameField.placeholder = @"Enter your new display name";
    UITextField *verifyPasswordField = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, 260, 35)];
    verifyPasswordField.placeholder = @"Verify your password";
    [labelView setText:@"Change your display name"];
    [labelView setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [newNameField setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [verifyPasswordField setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    labelView.textColor = [UIColor whiteColor];
    verifyPasswordField.textColor = [UIColor blueColor];
    newNameField.textColor = [UIColor blueColor];

    //add subviews to contentSubView
    [contentSubView addSubview:newNameField];
    [contentSubView addSubview:verifyPasswordField];
    [contentSubView addSubview:labelView];
    return contentSubView;
}

-(IBAction)changePassword:(id)sender
{
    CustomIOS7AlertView *changePassword = [[CustomIOS7AlertView alloc] init];
    [changePassword setContainerView:[self createPasswordView]];
    [changePassword setButtonTitles:[NSMutableArray arrayWithObjects:@"Cancel", @"Ok", nil]];
    [changePassword setUseMotionEffects:TRUE];
    [changePassword setDelegate:self];
    [changePassword show];
}

- (UIView *)createPasswordView
{
    //create post view, set its background color
    UIView *contentSubView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 125)];
    CAGradientLayer *grad = [CAGradientLayer layer];
    grad.frame = contentSubView.bounds;
    grad.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor] CGColor], (id)[[UIColor whiteColor] CGColor], nil];
    [contentSubView.layer insertSublayer:grad atIndex:0];
    
    //set text fields and label view properties
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 260, 20)];
    UITextField *currentPassword = [[UITextField alloc] initWithFrame:CGRectMake(10, 40, 260, 35)];
    currentPassword.placeholder = @"Enter your current password";
    UITextField *newPassword = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, 260, 35)];
    newPassword.placeholder = @"Enter your new password";
    UITextField *verifyPasswordField = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, 260, 35)];
    verifyPasswordField.placeholder = @"Re-type your new password";
    [labelView setText:@"Change your password"];
    [labelView setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    [verifyPasswordField setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [currentPassword setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [newPassword setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    labelView.textColor = [UIColor whiteColor];
    verifyPasswordField.textColor = [UIColor blueColor];
    newPassword.textColor = [UIColor blueColor];
    currentPassword.textColor = [UIColor blueColor];
    
    //add subviews to contentSubView
    [contentSubView addSubview:newPassword];
    [contentSubView addSubview:currentPassword];
    [contentSubView addSubview:verifyPasswordField];
    [contentSubView addSubview:labelView];
    return contentSubView;
}

-(IBAction)changeEmail:(id)sender
{
    _button = 2; //email button pressed
    CustomIOS7AlertView *changeEmail = [[CustomIOS7AlertView alloc] init];
    [changeEmail setContainerView:[self createEmailView]];
    [changeEmail setButtonTitles:[NSMutableArray arrayWithObjects:@"Cancel", @"Ok", nil]];
    [changeEmail setUseMotionEffects:TRUE];
    [changeEmail setDelegate:self];
    [changeEmail show];
}

- (UIView *)createEmailView
{
    //create post view, set its background color
    UIView *contentSubView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 165)];
    CAGradientLayer *grad = [CAGradientLayer layer];
    grad.frame = contentSubView.bounds;
    grad.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor] CGColor], (id)[[UIColor whiteColor] CGColor], nil];
    [contentSubView.layer insertSublayer:grad atIndex:0];
    
    //set text fields and label view properties
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 260, 20)];
    UITextField *oldEmailField = [[UITextField alloc] initWithFrame:CGRectMake(10, 40, 260, 35)];
    oldEmailField.placeholder = @"Enter your old email";
    UITextField *newEmailField = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, 260, 35)];
    newEmailField.placeholder = @"Enter your new email";
    UITextField *verifyPasswordField = [[UITextField alloc] initWithFrame:CGRectMake(10, 120, 260, 35)];
    verifyPasswordField.placeholder = @"Verify your password";
    [labelView setText:@"Change your email"];
    [labelView setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    [newEmailField setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [oldEmailField setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [verifyPasswordField setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    labelView.textColor = [UIColor whiteColor];
    newEmailField.textColor = [UIColor blueColor];
    oldEmailField.textColor = [UIColor blueColor];
    verifyPasswordField.textColor = [UIColor blueColor];
    
    //add subviews to contentSubView
    [contentSubView addSubview:oldEmailField];
    [contentSubView addSubview:newEmailField];
    [contentSubView addSubview:verifyPasswordField];
    [contentSubView addSubview:labelView];
    return contentSubView;
}

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //cancel
    if (buttonIndex == 0)
    {
        [alertView close];
    }
    //ok pressed
    else if (buttonIndex == 1)
    {
        if (_button == 0)
        {
            
            [alertView close];
        }
        else if (_button == 1)
        {
            
            [alertView close];
        }
    }
}

@end
