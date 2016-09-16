//
//  PVPostsViewController.m
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import "PVPostsViewController.h"
#import "PVLoginViewController.h"
static NSString *cellIdentifier = @"PostsCell";
int _tableVal = 0;  //0 for vibes, 1 for replies
@implementation PVPostsViewController

@synthesize loginViewController, postsCell, socketConnection, replyTableView, replyTable, portfileViewController, portalPageViewController, emptyListCell;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        [self.navigationItem setTitle:@"Vibes"];
        //get tab bar item
        UITabBarItem *tbi = [self tabBarItem];
        //give it a label
        [tbi setTitle:@"Vibes"];
        
        //create the UIImage from file
        UIImage *i = [UIImage imageNamed:@"posts.png"];
        [tbi setImage:i];
        
        if (postVibes == nil)
            postVibes = [[NSMutableArray alloc] init];
        
        //Use singleton to share socket connection to this view controller
        socketConnection = [PVSocketConnection sharedSingleton];
        socketConnection.delegate = self;
    }
    return self;
}

-(void)receivedPacket:(id)packet
{
    NSLog(@"Receiving packets...");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //estimate height for rows (performance boost)
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    
    //load cell nibs
    [self.tableView registerNib:[UINib nibWithNibName:@"PVPostsTableViewCell"
                                               bundle:nil] forCellReuseIdentifier:cellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"PVEmptyListTableViewCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"emptyCell"];
    
    //create menu button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:(PVMenuNavigationViewController *)self.navigationController
                                                                            action:@selector(showMenu)];
    
    //create a new vibe button in the title area where user can leave a message in their area
    newVibe = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"posts.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(newVibe)];
    
    //create a search button
    search = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(searchButton)];

    self.navigationItem.rightBarButtonItem = search;

    
    PVCoreLocationController *myLocation;
    if (myLocation == nil)
        myLocation = [[PVCoreLocationController alloc] init];
    myLocation.delegate = self;
    myLocation.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    CLLocation *currentLocation =  myLocation.locationManager.location;
    
    // Updating user's current location to server
    //[self sendUserCurrentCoordinate:currentLocation.coordinate];
    
    // start updating current location
    myLocation.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [myLocation.locationManager startUpdatingLocation];
}

- (void)locationUpdate:(CLLocation *)location
{
    NSLog(@"location %@", location);
}

- (void)locationError:(NSError *)error
{
    NSLog(@"locationdescription %@", [error description]);
}

-(void)searchButton
{
    
}

-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]])
    {
        [(UINavigationController *)viewController popToRootViewControllerAnimated:NO];
    }
}

-(void)newVibe
{
    CustomIOS7AlertView *newVibeView = [[CustomIOS7AlertView alloc] init];
    [newVibeView setContainerView:[self createDemoView]];
    [newVibeView setButtonTitles:[NSMutableArray arrayWithObjects:@"Cancel", @"Anonymous", @"Post", nil]];
    [newVibeView setUseMotionEffects:TRUE];
    [newVibeView setDelegate:self];
    [newVibeView show];
}

-(void)viewDidAppear:(BOOL)animated
{
    //[self getVibes];
    //singleton data
    PVSingletonData *singletonData = [PVSingletonData sharedID];
    //add buttons to nav bar
    if (singletonData.isLoggedIn)
    {
        self.navigationItem.rightBarButtonItems = @[newVibe, search];
    }
    
    [self.tableView reloadData];
    // reset the scrolling to the top of the table view
    if ([self tableView:self.tableView numberOfRowsInSection:0] > 0) {
        NSIndexPath *topIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:topIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

- (UIView *)createDemoView
{
    UIView *contentSubView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 125)];
    
    //background color
    CAGradientLayer *grad = [CAGradientLayer layer];
    grad.frame = contentSubView.bounds;
    grad.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor] CGColor], (id)[[UIColor whiteColor] CGColor], nil];
    [contentSubView.layer insertSublayer:grad atIndex:0];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 45, 260, 70)];
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 270, 20)];
    [labelView setText:@"Enter your vibes about this area"];
    labelView.textColor = [UIColor whiteColor];
    [labelView setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [textView setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
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
    //anonymous
    else if (buttonIndex == 1)
    {
        if (_tableVal == 0)
        {
            
            [alertView close];
        }
        else
        {
            
            [alertView close];
        }
    }
    //post
    else
    {
        if (_tableVal == 0)
        {
            
            [alertView close];
        }
        else
        {
            
            [alertView close];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if ([postVibes count] == 0)
    {
        return 1;
    }
    
    return [postVibes count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //empty vibes list, leave standard message
    if ([postVibes count] == 0)
    {
        return 210;
    }
    NSString *vibeText = [postVibes objectAtIndex:indexPath.row];
    CGFloat width = postsCell.userComment.frame.size.width;
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:vibeText
     attributes:@
     {
     NSFontAttributeName: font
     }];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize heightOfText = rect.size;
    return heightOfText.height+125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //check if theres no vibes around user
    if ([postVibes count] == 0)
    {
        emptyListCell = (PVEmptyListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"emptyCell"];
        emptyListCell.topImage.image = [UIImage imageNamed:@"posts.png"];
        //singleton data
        PVSingletonData *singletonData = [PVSingletonData sharedID];
        
        //if the user is logged in, change the text
        if (singletonData.isLoggedIn)
        {
            emptyListCell.label.text = @"There are currently no vibes in your area.  Be the first one to leave a vibe for other people to see!";
        }
        else
        {
            emptyListCell.label.text = @"There are currently no vibes in your area.  Login and be the first one to leave a vibe for other people to see!";
        }
        
        return emptyListCell;
    }
    
    postsCell = (PVPostsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //set user photo rounded picture
    postsCell.userPhoto.layer.cornerRadius = postsCell.userPhoto.frame.size.width/2;
    postsCell.userPhoto.clipsToBounds = YES;
    postsCell.userPhoto.layer.borderColor = [UIColor grayColor].CGColor;
    postsCell.userPhoto.layer.borderWidth = 1.5;
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%i", indexPath.row+1] ofType:@"jpeg"]];
    [postsCell.userPhoto setImage:image];
    
    //populate posts field
    
    //portfile button tag
    postsCell.displayName.tag = indexPath.row;
    [postsCell.displayName addTarget:self action:@selector(userButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //save portal button tag
    postsCell.portalName.tag = indexPath.row;
    [postsCell.portalName addTarget:self action:@selector(portalButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //reply button clicked. Set tag = indexPath.row
    postsCell.reply.tag = indexPath.row;
    [postsCell.reply addTarget:self action:@selector(replyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //hide delete button
    postsCell.deletePost.hidden = YES;
    
    return postsCell;
}

-(UIView *)createReplyView
{
    //create contentview and textview
    UIView *contentSubView;
    UITextView *textView;
    UILabel *labelView;
    
    //allocate replyTableView controller
    if (replyTableView == nil)
    {
        replyTableView = [[PVReplyTableViewController alloc] init];
    }
    [replyTable setDelegate:replyTableView];
    [replyTable setDataSource:replyTableView];
    replyTable = replyTableView.tableView;
    
    //iPhone 5+
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        contentSubView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 280)];
        textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 247, 280, 29)];
        labelView = [[UILabel alloc] initWithFrame:CGRectMake(10, 225, 280, 15)];
    }
    //iPhone <4s
    else
    {
        contentSubView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 230)];
        textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 207, 280, 19)];
        labelView = [[UILabel alloc] initWithFrame:CGRectMake(10, 190, 280, 15)];
    }
    
    CAGradientLayer *grad = [CAGradientLayer layer];
    grad.frame = contentSubView.bounds;
    grad.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor] CGColor], (id)[[UIColor whiteColor] CGColor], nil];
    [contentSubView.layer insertSublayer:grad atIndex:0];
    [labelView setText:@"Leave a reply:"];
    [labelView setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    labelView.textColor = [UIColor blackColor];
    [textView setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [contentSubView addSubview:textView];
    [contentSubView addSubview:labelView];
    
    //add the reply table to the contentSubView and reload the table
    [replyTable reloadData];
    [contentSubView addSubview:replyTable];
    return contentSubView;
}

-(void)userButtonClicked:(UIButton*)sender
{
    [[self navigationController] pushViewController:portfileViewController animated:YES];
}

-(void)replyButtonClicked:(UIButton*)sender
{
    CustomIOS7AlertView *replyView = [[CustomIOS7AlertView alloc] init];
    [replyView setContainerView:[self createReplyView]];
    [replyView setButtonTitles:[NSMutableArray arrayWithObjects:@"Cancel", @"Anonymous", @"Post", nil]];
    [replyView setUseMotionEffects:TRUE];
    [replyView setDelegate:self];
    [replyView show];
}

-(void)portalButtonClicked:(UIButton*)sender
{
    [[self navigationController] pushViewController:portalPageViewController animated:YES];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}



@end
