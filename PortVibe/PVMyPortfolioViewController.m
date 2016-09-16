//
//  PVMyPortfolioViewController.m
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import "PVMyPortfolioViewController.h"

@implementation PVMyPortfolioViewController
static NSString *myPostsCellIdentifier = @"PostsCell";
static NSString *friendsCellIdentifier = @"FriendsCell";
static NSString *portalCellIdentifier = @"PortalCell";
@synthesize postsCell, friendsCell, portalCell, userPhoto, socketConnection, userBlurb, displayName, descriptionTextView, replyTable, replyTableView, portalPageViewController, portfileViewController, tableView, userRep, emptyListCell;
int _tableType = 0;

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
        
        //get tab bar item
        UITabBarItem *tbi = [self tabBarItem];
        //give it a label
        [tbi setTitle:@"Portfile"];
        //create the UIImage from file
        UIImage *i = [UIImage imageNamed:@"portfiles.png"];
        [tbi setImage:i];
        [self.navigationItem setTitle:@"Portfile"];
        
        if (portals == nil)
            portals = [[NSMutableArray alloc] init];
        if (friends == nil)
            friends = [[NSMutableArray alloc] init];
        if (activity == nil)
            activity = [[NSMutableArray alloc] init];
        
        //Use singleton to share socket connection to view controller
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
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        //create tableview.  Set the height for iphone 5+
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 208, 320, self.view.bounds.size.height-257) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
    }
    else
    {
        //create tableview for iphone <4s
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 208, 320, self.view.bounds.size.height-345) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
    }
    
    //set user photo rounded picture
    userPhoto.layer.cornerRadius = userPhoto.frame.size.width/2;
    userPhoto.clipsToBounds = YES;
    userPhoto.layer.borderColor = [UIColor whiteColor].CGColor;
    userPhoto.layer.borderWidth = 1.5;
    
    //register nibs
    [self.tableView registerNib:[UINib nibWithNibName:@"PVPostsTableViewCell"
                                               bundle:nil]
         forCellReuseIdentifier:myPostsCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"PVFriendsTableViewCell"
                                               bundle:nil]
         forCellReuseIdentifier:friendsCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"PVPortalsTableViewCell"
                                               bundle:nil]
         forCellReuseIdentifier:portalCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"PVEmptyListTableViewCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"emptyCell"];
    
    //estimate height for rows (performance boost)
    tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    
    //create a search button
    search = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(searchButton)];

    //create menu button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:(PVMenuNavigationViewController *)self.navigationController
                                                                            action:@selector(showMenu)];
}

-(void)viewDidAppear:(BOOL)animated
{
    //singleton data
    PVSingletonData *singletonData = [PVSingletonData sharedID];
    //fill data on portfolio based on user
    displayName.text = singletonData.userDisplayName;
    userRep.text = [NSString stringWithFormat:@"Rep: %@", [singletonData rep]];
    
    [self.tableView reloadData];
    // reset the scrolling to the top of the table view
    if ([self tableView:self.tableView numberOfRowsInSection:0] > 0)
    {
        NSIndexPath *topIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:topIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
    
    //create a new vibe button in the title area where user can leave a message in their area
    newVibe = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"posts.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(newVibe)];
    self.navigationItem.rightBarButtonItems = @[newVibe, search];
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

- (IBAction)descriptionButtonPressed:(id)sender
{
    CustomIOS7AlertView *enterDescriptionView = [[CustomIOS7AlertView alloc] init];
    [enterDescriptionView setContainerView:[self createDescriptionView]];
    [enterDescriptionView setButtonTitles:[NSMutableArray arrayWithObjects:@"Cancel", @"OK", nil]];
    [enterDescriptionView setUseMotionEffects:TRUE];
    [enterDescriptionView setDelegate:self];
    [enterDescriptionView show];
}

- (UIView *)createDescriptionView
{
    UIView *contentSubView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 125)];
    //custom backgorund color gradient
    CAGradientLayer *grad = [CAGradientLayer layer];
    grad.frame = contentSubView.bounds;
    grad.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor] CGColor], (id)[[UIColor whiteColor] CGColor], nil];
    [contentSubView.layer insertSublayer:grad atIndex:0];
    
    descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 45, 260, 70)];
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 270, 20)];
    [labelView setText:@"Enter a description about yourself"];
    [labelView setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    labelView.textColor = [UIColor whiteColor];
    [descriptionTextView setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [contentSubView addSubview:descriptionTextView];
    [contentSubView addSubview:labelView];
    return contentSubView;
}

//upload a user portfile photo
- (IBAction)photoButtonPressed:(id)sender
{
    
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

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [alertView close];
    }
    else
    {
        [userBlurb setText:descriptionTextView.text];
        [alertView close];
    }
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (_tableType == 2)
    {
        if ([portals count] == 0)
        {
            return 1;
        }
        return [portals count];
    }
    else if (_tableType == 1)
    {
        if ([friends count] == 0)
        {
            return 1;
        }
        return [friends count];
    }
    else
    {
        if ([activity count] == 0)
        {
            return 1;
        }
        return [activity count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tableType == 2)
    {
        if ([portals count] == 0)
        {
            return 210;
        }
        return 135;
    }
    else if (_tableType == 1)
    {
        if ([friends count] == 0)
        {
            return 210;
        }
        return 100;
    }
    else
    {
        if ([activity count] == 0)
        {
            return 210;
        }
        NSString *vibeText = [activity objectAtIndex:indexPath.row];
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
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //portals subscribed tab
    if (_tableType == 2)
    {
        //check if user has any portals subscribed
        if ([portals count] == 0)
        {
            emptyListCell = (PVEmptyListTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"emptyCell"];
            emptyListCell.topImage.image = [UIImage imageNamed:@"portalPic.png"];
            emptyListCell.label.text = @"You are not subscribed to any Portals. Subscribe to a Portal or place one of your own and start feeling the vibes!";
            return emptyListCell;
        }
        
        portalCell = (PVPortalsTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:portalCellIdentifier];
        
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"portal%i", indexPath.row+1] ofType:@"jpeg"]];
        [portalCell.portalImage setImage:image];
        [portalCell.portIn setTitle:@"Unsubscribe" forState:UIControlStateNormal];
        [portalCell.portIn setImage:nil forState:UIControlStateNormal];
        
        portalCell.portalImage.layer.cornerRadius = portalCell.portalImage.frame.size.height/2.8;
        portalCell.portalImage.layer.masksToBounds = YES;
        portalCell.portalImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
        portalCell.portalImage.layer.borderWidth = 1.0;
        
        //save portal button tag
        portalCell.portalName.tag = indexPath.row;
        [portalCell.portalName addTarget:self action:@selector(portalButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        //unfriend button clicked. Set tag = indexPath.row
        portalCell.portIn.tag = indexPath.row;
        [portalCell.portIn addTarget:self action:@selector(unsubscribeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        return portalCell;
    }
    //friends tab
    else if (_tableType == 1)
    {
        //check if user has any friends added
        if ([friends count] == 0)
        {
            emptyListCell = (PVEmptyListTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"emptyCell"];
            emptyListCell.topImage.image = [UIImage imageNamed:@"plusFriend.png"];
            emptyListCell.label.text = @"You haven't added any friends.  Use the search button to add some friends and see what they're up to!";
            return emptyListCell;
        }
        friendsCell = (PVFriendsTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:friendsCellIdentifier];

        UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%i", indexPath.row+1] ofType:@"jpeg"]];
        [friendsCell.userPhoto setImage:image];
        
        //set user photo rounded picture
        friendsCell.userPhoto.layer.cornerRadius = friendsCell.userPhoto.frame.size.width/2;
        friendsCell.userPhoto.clipsToBounds = YES;
        friendsCell.userPhoto.layer.borderColor = [UIColor grayColor].CGColor;
        friendsCell.userPhoto.layer.borderWidth = 1.5;
        
        //user button clicked. Set tag = indexPath.row
        friendsCell.displayName.tag = indexPath.row;
        [friendsCell.displayName addTarget:self action:@selector(userButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        //message clicked. Set tag = indexPath.row
        friendsCell.message.tag = indexPath.row;
        [friendsCell.message addTarget:self action:@selector(messageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        //unfriend button clicked. Set tag = indexPath.row
        friendsCell.unfriend.tag = indexPath.row;
        [friendsCell.unfriend addTarget:self action:@selector(unfriendButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        return friendsCell;
    }
    //Vibes (activity tab)
    else
    {
        //check if user has any friends added
        if ([activity count] == 0)
        {
            emptyListCell = (PVEmptyListTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"emptyCell"];
            emptyListCell.label.text = @"You have no activity.  Leave some vibes of your own to get started!";
            emptyListCell.topImage.image = [UIImage imageNamed:@"posts.png"];

            return emptyListCell;
        }
        postsCell = (PVPostsTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:myPostsCellIdentifier];

        UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"cartman"] ofType:@"png"]];
        [postsCell.userPhoto setImage:image];
        
        //hide unnecessary images/labels/buttons
        postsCell.distanceImage.hidden = YES;
        postsCell.postDistance.hidden = YES;
        
        //set user photo rounded picture
        postsCell.userPhoto.layer.cornerRadius = postsCell.userPhoto.frame.size.width/2;
        postsCell.userPhoto.clipsToBounds = YES;
        postsCell.userPhoto.layer.borderColor = [UIColor grayColor].CGColor;
        postsCell.userPhoto.layer.borderWidth = 1.5;
        
        //user button clicked. Set tag = indexPath.row
        friendsCell.displayName.tag = indexPath.row;
        [friendsCell.displayName addTarget:self action:@selector(userButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        //portal button clicked. Set tag = indexPath.row
        postsCell.portalName.tag = indexPath.row;
        [postsCell.portalName addTarget:self action:@selector(portalButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        //reply button clicked. Set tag = indexPath.row
        postsCell.reply.tag = indexPath.row;
        [postsCell.reply addTarget:self action:@selector(replyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        //unfriend button clicked. Set tag = indexPath.row
        postsCell.deletePost.tag = indexPath.row;
        [postsCell.deletePost addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        return postsCell;
    }
}

-(void)messageButtonClicked:(UIButton*)sender
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
    [labelView setText:[NSString stringWithFormat:@"Send a message?"]];
    [labelView setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [textView setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    labelView.textColor = [UIColor whiteColor];
    
    //add subviews to contentSubView
    [contentSubView addSubview:textView];
    [contentSubView addSubview:labelView];
    return contentSubView;
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

-(void)replyButtonClicked:(UIButton*)sender
{
    CustomIOS7AlertView *replyView = [[CustomIOS7AlertView alloc] init];
    [replyView setContainerView:[self createReplyView]];
    [replyView setButtonTitles:[NSMutableArray arrayWithObjects:@"Cancel", @"Anonymous", @"Post", nil]];
    [replyView setUseMotionEffects:TRUE];
    [replyView setDelegate:self];
    [replyView show];
}

-(void)userButtonClicked:(UIButton*)sender
{
    [[self navigationController] pushViewController:portfileViewController animated:YES];
}

-(void)unsubscribeButtonClicked:(UIButton*)sender
{
    UIAlertView *userWarning = [[UIAlertView alloc] initWithTitle:@"Unsubscribe?"
                                                          message:@"Are you sure you wish to unsubscribe?"
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"Continue", nil];
    _alert = 2;
    _cellTag = sender.tag;
    [userWarning show];
}

-(void)unfriendButtonClicked:(UIButton*)sender
{
    UIAlertView *userWarning = [[UIAlertView alloc] initWithTitle:@"Unfriend?"
                                                          message:@"Are you sure you wish to unfriend?"
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"Continue", nil];
    _alert = 1;
    _cellTag = sender.tag;
    [userWarning show];
}

-(void)deleteButtonClicked:(UIButton*)sender
{
    UIAlertView *userWarning = [[UIAlertView alloc] initWithTitle:@"Delete Post?"
                                                          message:@"Are you sure you wish to delete your post? There is no undoing this, but you will still keep the reputation points gained from the post."
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"Continue", nil];
    _alert = 0;
    _cellTag = sender.tag;
    [userWarning show];
}

//set up button responses for each alert view
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //delete post alert
    if (_alert == 0)
    {
        //continue clicked
        if (buttonIndex == 1)
        {
            [activity removeObjectAtIndex:_cellTag];
            [tableView reloadData];
        }
    }
    //unfriend alert
    else if (_alert == 1)
    {
        //continue clicked
        if (buttonIndex == 1)
        {
            [friends removeObjectAtIndex:_cellTag];
            [tableView reloadData];
        }
    }
    //unsubscribe portal alert
    else if (_alert == 2)
    {
        //continue clicked
        if (buttonIndex == 1)
        {
            [portals removeObjectAtIndex:_cellTag];
            [tableView reloadData];
        }
    }
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

-(IBAction) segmentedControlIndexChanged
{
    switch (self.segmentedControl.selectedSegmentIndex)
    {
        case 0:
            _tableType = 0;
            [self.tableView reloadData];
            // reset the scrolling to the top of the table view
            if ([self tableView:self.tableView numberOfRowsInSection:0] > 0) {
                NSIndexPath *topIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.tableView scrollToRowAtIndexPath:topIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            }
            break;
        case 1:
            _tableType = 1;
            [self.tableView reloadData];
            // reset the scrolling to the top of the table view
            if ([self tableView:self.tableView numberOfRowsInSection:0] > 0) {
                NSIndexPath *topIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.tableView scrollToRowAtIndexPath:topIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            }
            break;
        case 2:
            _tableType = 2;
            [self.tableView reloadData];
            // reset the scrolling to the top of the table view
            if ([self tableView:self.tableView numberOfRowsInSection:0] > 0) {
                NSIndexPath *topIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.tableView scrollToRowAtIndexPath:topIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            }
            break;
        default:
            break;
    }
}

@end
