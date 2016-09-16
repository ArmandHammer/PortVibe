//
//  PVPortalsViewController.m
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import "PVPortalsViewController.h"
#import "PVMapviewViewController.h"
static NSString *cellIdentifier = @"PortalsCell";

@implementation PVPortalsViewController

@synthesize mapviewViewController, portalCell, socketConnection, portalPageViewController, emptyListCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self.navigationController popToRootViewControllerAnimated:NO];
        [self.navigationItem setTitle:@"Portals"];
        //get tab bar item
        UITabBarItem *tbi = [self tabBarItem];
        //give it a label
        [tbi setTitle:@"Portals"];
        
        if (portals == nil)
            portals = [[NSMutableArray alloc] init];
        
        //create the UIImage from file
        UIImage *i = [UIImage imageNamed:@"Portal.png"];
        [tbi setImage:i];
        
        //Use singleton to share socket connection to view controller
        socketConnection = [PVSocketConnection sharedSingleton];
        socketConnection.delegate = self;
    }
    return self;
}

-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]])
    {
        [(UINavigationController *)viewController popToRootViewControllerAnimated:NO];
    }
}

-(void)receivedPacket:(id)packet
{
    NSLog(@"Receiving packets...");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PVPortalsTableViewCell"
                                               bundle:nil]
         forCellReuseIdentifier:cellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"PVEmptyListTableViewCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"emptyCell"];

    //create menu button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:(PVMenuNavigationViewController *)self.navigationController
                                                                            action:@selector(showMenu)];

    //create a mapview button in the title area
    UIBarButtonItem *mapviewButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mapview.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(mapviewPage)];
    
    //create a search button
    search = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(searchButton)];
    self.navigationItem.rightBarButtonItems = @[mapviewButton, search];
}

-(void)searchButton
{
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
    // reset the scrolling to the top of the table view
    if ([self tableView:self.tableView numberOfRowsInSection:0] > 0) {
        NSIndexPath *topIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:topIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

-(void)mapviewPage
{
    [[self navigationController] pushViewController:mapviewViewController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if ([portals count] == 0)
    {
        return 1;
    }
    return [portals count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //empty portals list, leave standard message
    if ([portals count] == 0)
    {
        return 210;
    }
    return 135;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //If there's no portals around user
    if ([portals count] == 0)
    {
        emptyListCell = (PVEmptyListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"emptyCell"];
        emptyListCell.topImage.image = [UIImage imageNamed:@"portalPic.png"];
        
        //singleton data
        PVSingletonData *singletonData = [PVSingletonData sharedID];
        //if the user is logged in, change the text
        if (singletonData.isLoggedIn)
        {
            emptyListCell.label.text = @"There are currently no portals in your area.  Capitalize on this opportunity and be the first one to drop a portal on a point of interest around you!";
        }
        else
        {
            emptyListCell.label.text = @"There are currently no portals in your area.  Login and be the first one to drop a portal on a point of interest around you!";
        }
        return emptyListCell;
    }
    
    portalCell = (PVPortalsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //[portalCell.portalImage setImage:image];
    portalCell.portalImage.layer.cornerRadius = portalCell.portalImage.frame.size.height/2.8;
    portalCell.portalImage.layer.masksToBounds = YES;
    portalCell.portalImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    portalCell.portalImage.layer.borderWidth = 1.0;
    
    //portal button tag
    portalCell.portalName.tag = indexPath.row;
    [portalCell.portalName addTarget:self action:@selector(portalButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return portalCell;
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
