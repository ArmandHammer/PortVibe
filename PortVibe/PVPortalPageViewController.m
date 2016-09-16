//
//  PVPortalPageViewController.m
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import "PVPortalPageViewController.h"

@implementation PVPortalPageViewController
@synthesize portalDescription, portalDescriptionButton, portalImage, postsCell, announcement, announcementButton, portalName, currentPortIn, subscribers, portfileViewController, replyTableView, replyTable, tableView;
static NSString *myPostsCellIdentifier = @"PostsCell";
static NSString *myReplyCellIdentifier = @"ReplyCell";

- (id)init
{
    self = [super init];
    if (self)
    {
        //custom backgorund color gradient
        CAGradientLayer *grad = [CAGradientLayer layer];
        grad.frame = self.view.bounds;
        grad.colors = [NSArray arrayWithObjects:(id)[[UIColor blueColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
        [self.view.layer insertSublayer:grad atIndex:0];
        
        displayNames = [[NSArray alloc] initWithObjects:@"JimmyCrackCorn33", @"Dudette", @"SportsGuy111222", @"SoccerPlayer123", @"KobeFan", @"Athlete3322", @"BasketballFan", @"TetrisChamp22", @"Solipsism", nil];
        friendsBlurb = [[NSArray alloc] initWithObjects:@"TEsdfs sdfsdfsdfsdfsdfsdfsdfsdfsdfwere54 wasdf adfsdfasdfsd STNSDJN", @"asdznvkjhvdh dfoghoudsfhgousdhfgouh sdofhgoudsfhgodshfgou sdfohgoudsfhgoudshfgoudhsfoug doshgodsfuhgou dofshgoudsfhgohsdoghdsoufhgodshfoghdousfhgoudsfhgodshfoughdsoufgh dfouhgoudsfhguodshfgouhdsfogh odfughosudhgou123", @"123455511231312423425243534253452452314", @"aaasssasdasdasdasssssdddddsdfsdfsdfd", @"aaasssasdasdasdasssssdsdfsadkfsdifhsdifhiueh8qh4785h27 vusdhf whf iasudhf iuasdhf asidfhiusdhfiusahf siduhf9qr98qudfddddsdfsdfsdfd", @"aaadsfghdiushguidfhgiudhg iduhgiudsghiudsh iughdihsid gidshfg idshfgisdfgh idisfgidshfgidhsfgiudsfg oudsfg iuds figuhdsfiughdsiufhg iuds fhiguhdsfiuhgidusfgi udfhsgiudsfhiguh dfiu ghdiusfhgiudsfhgidhighdifuhguisdfg huidfhgiudfhgiuhdfuighduisfhg dfhgiudshgiudhsfguihdsfiugh disghiusdfhg idshgidsfgihsdfiug sdifhgiudsfhgisdgheiohgiusdhfgisdbvisbd figh sdifoghdsiuges ig sssasdasdasda1111sssssdddddsdfsdfsdfd", @"ldkfnsdf sdfsdjhfoisdhfoi shdofhsofhsud oufhsodu foshdfoshfoshdfouhw98h4r982h 4924y592y9fhs9f 9sdf9hd98f s98fsyd98fs9dhfosduhfosdf oshfo", @"sdlkf sdjfsdjf", @"dsflkmsdfj sdokfnojsdn fosfh sodhfosdhfoh4985h q398ht98 29y62794y589y62495y69724 y59y6297yg97ytr7yg793y79gy45397ty34795yg7934yt794y3579ty43795yt7943yt97y459", nil];
        userTime = [[NSArray alloc] initWithObjects:@"39 mins", @"3 hours", @"7 hours", @"11 hours", @"Yesterday", @"Yesterday", @"Yesterday", @"23/06/02", @"21/06/02", nil];
        
        [self.navigationItem setTitle:@"Portal Page"];
    }
    return self;
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
    
    //allocate replyTableView controller
    if (replyTableView == nil)
    {
        replyTableView = [[PVReplyTableViewController alloc] init];
    }
    [replyTable setDelegate:replyTableView];
    [replyTable setDataSource:replyTableView];
    replyTable = replyTableView.tableView;
    
    //create a new vibe button inside this portal
    UIBarButtonItem *newVibe = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"posts.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(newVibe)];
    
    //create a search button
    UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(searchButton)];
    self.navigationItem.rightBarButtonItems = @[newVibe, search];
    
    //register nibs
    [self.tableView registerNib:[UINib nibWithNibName:@"PVPostsTableViewCell"
                                               bundle:nil]
         forCellReuseIdentifier:myPostsCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"PVReplyTableViewCell"
                                               bundle:nil]
         forCellReuseIdentifier:myReplyCellIdentifier];
    
    //set user photo rounded corners
    portalImage.layer.cornerRadius = portalImage.frame.size.height/2.8;
    portalImage.layer.masksToBounds = YES;
    portalImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    portalImage.layer.borderWidth = 1.0;
}

-(void)searchButton
{
    
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
    //create post view, set its background color
    UIView *contentSubView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 125)];
    CAGradientLayer *grad = [CAGradientLayer layer];
    grad.frame = contentSubView.bounds;
    grad.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor] CGColor], (id)[[UIColor whiteColor] CGColor], nil];
    [contentSubView.layer insertSublayer:grad atIndex:0];
    
    //set text view and label view properties
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 45, 260, 65)];
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 270, 20)];
    [labelView setText:@"Enter your vibes in this portal:"];
    [labelView setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [textView setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    labelView.textColor = [UIColor whiteColor];
    
    //add subviews to contentSubView
    [contentSubView addSubview:textView];
    [contentSubView addSubview:labelView];
    return contentSubView;
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
    // reset the scrolling to the top of the table view
    if ([self tableView:self.tableView numberOfRowsInSection:0] > 0)
    {
        NSIndexPath *topIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:topIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [friendsBlurb count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *vibeText = [friendsBlurb objectAtIndex:indexPath.row];
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

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    postsCell = (PVPostsTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:myPostsCellIdentifier];
    
    //fill in data
    postsCell.userComment.text = [friendsBlurb objectAtIndex:indexPath.row];
    [postsCell.displayName setTitle:[displayNames objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    [postsCell.portalName setTitle:portalName.text forState:UIControlStateNormal];
    postsCell.postTime.text = [userTime objectAtIndex:indexPath.row];
    
    //hide unnecessary buttons/images
    postsCell.distanceImage.hidden = YES;
    postsCell.postDistance.hidden = YES;
    postsCell.deletePost.hidden = YES;
    
    //set user photo rounded picture
    postsCell.userPhoto.layer.cornerRadius = postsCell.userPhoto.frame.size.width/2;
    postsCell.userPhoto.clipsToBounds = YES;
    postsCell.userPhoto.layer.borderColor = [UIColor grayColor].CGColor;
    postsCell.userPhoto.layer.borderWidth = 1.5;
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%i", indexPath.row+1] ofType:@"jpeg"]];
    [postsCell.userPhoto setImage:image];
    
    //portfile button tag
    postsCell.displayName.tag = indexPath.row;
    [postsCell.displayName addTarget:self action:@selector(userButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //reply button tag
    postsCell.reply.tag = indexPath.row;
    [postsCell.reply addTarget:self action:@selector(replyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //like button tag
    postsCell.like.tag = indexPath.row;
    [postsCell.like addTarget:self action:@selector(likeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //report button tag
    postsCell.report.tag = indexPath.row;
    [postsCell.report addTarget:self action:@selector(reportButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
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

-(void)replyButtonClicked:(UIButton*)sender
{
    CustomIOS7AlertView *replyView = [[CustomIOS7AlertView alloc] init];
    [replyView setContainerView:[self createReplyView]];
    [replyView setButtonTitles:[NSMutableArray arrayWithObjects:@"Cancel", @"Anonymous", @"Post", nil]];
    [replyView setUseMotionEffects:TRUE];
    [replyView setDelegate:self];
    [replyView show];
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
        [alertView close];
    }
    //post
    else
    {
        [alertView close];
    }
}

-(void)reportButtonClicked:(UIButton*)sender
{
    
}

-(void)dislikeButtonClicked:(UIButton*)sender
{
    
}

-(void)likeButtonClicked:(UIButton*)sender
{

}

-(void)userButtonClicked:(UIButton*)sender
{
    [[self navigationController] pushViewController:portfileViewController animated:YES];
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
