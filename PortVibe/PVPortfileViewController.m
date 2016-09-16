//
//  PVPortfileViewController.m
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import "PVPortfileViewController.h"

@implementation PVPortfileViewController
@synthesize userImage, addFriend, reportUser, userDescription, userName, userRep;

- (id)init
{
    self = [super init];
    if (self)
    {
        //custom backgorund color gradient
        CAGradientLayer *grad = [CAGradientLayer layer];
        grad.frame = self.view.bounds;
        grad.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor] CGColor], (id)[[UIColor whiteColor] CGColor], nil];
        [self.view.layer insertSublayer:grad atIndex:0];
        
        //set user photo rounded corners
        userImage.layer.cornerRadius = userImage.frame.size.height/2.8;
        userImage.layer.masksToBounds = YES;
        userImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
        userImage.layer.borderWidth = 1.0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //singleton data
    PVSingletonData *singletonData = [PVSingletonData sharedID];
    
    //create a mapview button in the title area
    UIBarButtonItem *message = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"message.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(messageButton)];
    
    //create a search button
    UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(searchButton)];
    self.navigationItem.rightBarButtonItems = @[message, search];
}

-(void)searchButton
{
    
}

-(void)messageButton
{
    CustomIOS7AlertView *newMessage = [[CustomIOS7AlertView alloc] init];
    [newMessage setContainerView:[self createMessageView]];
    [newMessage setButtonTitles:[NSMutableArray arrayWithObjects:@"Cancel", @"Message", nil]];
    [newMessage setUseMotionEffects:TRUE];
    [newMessage setDelegate:self];
    [newMessage show];
}

- (UIView *)createMessageView
{
    //create post view, set its background color
    UIView *contentSubView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 125)];
    CAGradientLayer *grad = [CAGradientLayer layer];
    grad.frame = contentSubView.bounds;
    grad.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor] CGColor], (id)[[UIColor whiteColor] CGColor], nil];
    [contentSubView.layer insertSublayer:grad atIndex:0];
    
    //set text view and label view properties
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 45, 260, 65)];
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 270, 20)];
    [labelView setText:[NSString stringWithFormat:@"Send a message to %@:", userName.text]];
    [labelView setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [textView setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    labelView.textColor = [UIColor whiteColor];
    
    //add subviews to contentSubView
    [contentSubView addSubview:textView];
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
    //message
    else
    {
        //code to send message to the specified user
        
        [alertView close];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
