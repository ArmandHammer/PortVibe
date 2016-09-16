//
//  PVMenuTableViewController.m
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import "PVMenuTableViewController.h"
#import "PVAppDelegate.h"

static NSString *gpsIdentifier = @"GPSCellIdentifier";
static NSString *serviceName = @"PortVibe";

@implementation PVMenuTableViewController
@synthesize gpsTableViewCell;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.alwaysBounceVertical = NO;
    //create menu list
    menuItems = [[NSArray alloc] init];
    
    //custom backgorund color gradient
    CAGradientLayer *grad = [CAGradientLayer layer];
    grad.frame = self.view.bounds;
    grad.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor] CGColor], (id)[[UIColor whiteColor] CGColor], nil];
    [self.view.layer insertSublayer:grad atIndex:0];
    
    //register nibs
    [self.tableView registerNib:[UINib nibWithNibName:@"PVGPSCellTableViewCell"
                                               bundle:nil]
         forCellReuseIdentifier:gpsIdentifier];

    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 40, 100, 100)];
        
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 50.0;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 2.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
        //set rep labels and properties
        repLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 100, 20)];
        
        repLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        repLabel.backgroundColor = [UIColor clearColor];
        repLabel.textColor = [UIColor whiteColor];
        
        //set badges labels and properties such as underlined
        UILabel *badgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 70, 100, 20)];
        badgeLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        badgeLabel.backgroundColor = [UIColor clearColor];
        badgeLabel.textColor = [UIColor whiteColor];
        NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
        badgeLabel.attributedText = [[NSAttributedString alloc] initWithString:@"Badges"
                                                                 attributes:underlineAttribute];
        
        //create and set badge images for user
        badge1 = [[UIImageView alloc] initWithFrame:CGRectMake(120, 95, 26, 32)];
        
        //create and set badge images for user
        badge2 = [[UIImageView alloc] initWithFrame:CGRectMake(152, 95, 26, 32)];
        
        //create and set badge images for user
        badge3 = [[UIImageView alloc] initWithFrame:CGRectMake(184, 95, 26, 32)];
        
        //set this to user's name
        userName = [[UILabel alloc] initWithFrame:CGRectMake(15, 150, 295, 24)];
        userName.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        userName.backgroundColor = [UIColor clearColor];
        userName.textColor = [UIColor whiteColor];
        
        [view addSubview:imageView];
        [view addSubview:repLabel];
        [view addSubview:badgeLabel];
        [view addSubview:badge1];
        [view addSubview:badge2];
        [view addSubview:badge3];
        [view addSubview:userName];

        view;
    });
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //singleton data
    PVSingletonData *singletonData = [PVSingletonData sharedID];
    //menu button 1 will always be GPS settings.  Start with menu button 2
    if (indexPath.row == 1)
    {
        if (singletonData.isLoggedIn)
        {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            //PVMessageScreenViewController *messageScreen = [[PVMessageScreenViewController alloc] init];
            //PVMenuNavigationViewController *navigationController = [[PVMenuNavigationViewController alloc] initWithRootViewController:messageScreen];
            //self.frostedViewController.contentViewController = navigationController;
            [self.frostedViewController hideMenuViewController];
        }
        else
        {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            PVLoginViewController *loginViewController = [[PVLoginViewController alloc] init];
            PVMenuNavigationViewController *navigationController = [[PVMenuNavigationViewController alloc] initWithRootViewController:loginViewController];
            self.frostedViewController.contentViewController = navigationController;
            [self.frostedViewController hideMenuViewController];
        }
    }
    else if (indexPath.row == 2)
    {
        if (singletonData.isLoggedIn)
        {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            PVAccountSettingsViewController *accountSettingsViewController = [[PVAccountSettingsViewController alloc] init];
            PVMenuNavigationViewController *navigationController = [[PVMenuNavigationViewController alloc] initWithRootViewController:accountSettingsViewController];
            self.frostedViewController.contentViewController = navigationController;
            [self.frostedViewController hideMenuViewController];
        }
        else
        {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            PVRegisterViewController *registerViewController = [[PVRegisterViewController alloc] init];
            PVMenuNavigationViewController *navigationController = [[PVMenuNavigationViewController alloc] initWithRootViewController:registerViewController];
            self.frostedViewController.contentViewController = navigationController;
            [self.frostedViewController hideMenuViewController];
        }
    }
    else if (indexPath.row == 3)
    {
        if (singletonData.isLoggedIn)
        {
            UIAlertView *logoutWarning = [[UIAlertView alloc] initWithTitle:@"Logout?"
                                                                  message:@"Are you sure you wish to logout?"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                        otherButtonTitles:@"Continue", nil];
            [logoutWarning show];
        }
        else
        {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            PVForgotPasswordViewController *forgotPasswordViewController = [[PVForgotPasswordViewController alloc] init];
            PVMenuNavigationViewController *navigationController = [[PVMenuNavigationViewController alloc] initWithRootViewController:forgotPasswordViewController];
            self.frostedViewController.contentViewController = navigationController;
            [self.frostedViewController hideMenuViewController];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        //singleton data
        PVSingletonData *singletonData = [PVSingletonData sharedID];
        //logout confirmed.  Reset keys and reset singleton data
        NSError *error = nil;
        [SFHFKeychainUtils deleteItemForUsername:singletonData.userEmail andServiceName:serviceName error:&error];
        [singletonData resetValues];
        PVAppDelegate *appDelegate = (PVAppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:appDelegate.tabBarController menuViewController:appDelegate.menuTableViewController];
        [[[[appDelegate.tabBarController tabBar]items]objectAtIndex:0]setEnabled:FALSE];
        [[[[appDelegate.tabBarController tabBar]items]objectAtIndex:3]setEnabled:FALSE];
        [appDelegate.tabBarController setSelectedIndex:1];
        [appDelegate.window setRootViewController:appDelegate.frostedViewController];
        [appDelegate.window makeKeyAndVisible];
        [self.frostedViewController hideMenuViewController];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    //singleton data
    PVSingletonData *singletonData = [PVSingletonData sharedID];
    if (singletonData.isLoggedIn)
    {
        menuItems = @[@"GPS", @"Messages", @"Account Settings", @"Logout"];
        badge1.image = [UIImage imageNamed:@"sheriffBadge.png"];
        badge2.image = [UIImage imageNamed:@"bossBadge.png"];
        badge3.image = [UIImage imageNamed:@"mouthBadge.png"];
        userName.text = [singletonData userDisplayName];
        repLabel.text = [NSString stringWithFormat:@"Rep: %@", [singletonData rep]];
        imageView.image = [UIImage imageNamed:@"cartman.png"];
    }
    else
    {
        menuItems = @[@"GPS", @"Login", @"Register", @"Forgot Password"];
        repLabel.text = @"Rep: ?";
        userName.text = @"Unknown PortViber";
        imageView.image = [UIImage imageNamed:@"anonymousPhoto.png"];
        badge1.image = nil;
        badge2.image = nil;
        badge3.image = nil;
    }

    [self.tableView reloadData];
    // reset the scrolling to the top of the table view
    if ([self tableView:self.tableView numberOfRowsInSection:0] > 0)
    {
        NSIndexPath *topIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:topIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (indexPath.row == 0)
    {
        gpsTableViewCell = (PVGPSCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:gpsIdentifier];
        return gpsTableViewCell;
    }
    else
    {
        cell.textLabel.text = menuItems[indexPath.row];
    }

    return cell;
}

@end
