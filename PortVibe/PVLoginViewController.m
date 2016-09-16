//
//  PVLoginViewController.m
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import "PVLoginViewController.h"
#import "PVAppDelegate.h"
static NSString *serviceName = @"PortVibe";
@implementation PVLoginViewController
@synthesize email, password;
bool _isConnected = false;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self.navigationItem setTitle:@"Login"];
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
    email.clearButtonMode = UITextFieldViewModeWhileEditing; //enable clear button in text field
    password.clearButtonMode = UITextFieldViewModeWhileEditing; //enable clear button in text field
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [email resignFirstResponder];
    [password resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [email resignFirstResponder];
    [password resignFirstResponder];
    return YES;
}

-(IBAction)loginButton:(id)sender
{
    if (email.text.length > 5)
    {
        if (password.text.length >= 5)
        {
            //grab user/password strings
            userEmail = email.text;
            userPassword = password.text;
            
            [self loginConnection];
        }
    }
    else
    {
        // Create and show an alert view with this error displayed
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error"
                                                     message:@"Incorrect email or password."
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
        [av show];
    }
}

-(void)loginConnection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    //send URL request to authenticate login
    NSString *urlString = @"http://guarded-tor-3762.herokuapp.com/login.json";
    NSURL *webURL = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:webURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSError *error;
    
    // Convert your data and set your request's HTTPBody property
    NSDictionary *loginData = [NSDictionary
                               dictionaryWithObjectsAndKeys: email.text, @"username", password.text, @"password",
                               nil];
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:loginData
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLResponse *response;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (returnData)
    {
        NSLog(@"Received %d bytes of data.", [returnData length]);
        NSError* error;
        //parse json
        NSArray *jsonArray = [NSJSONSerialization
                               JSONObjectWithData:returnData
                               options:kNilOptions
                               error:&error];
        
        NSString *printString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        //check for
        if ([printString isEqual: @"Wrong password or Wrong Username"])
        {
            _isConnected = false;
            // Create and show an alert view with this error displayed
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:printString
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
            [av show];
        }
        else
        {
            _isConnected = true;
        }

        //on success
        if (_isConnected)
        {
            //store credentials
            [SFHFKeychainUtils storeUsername:userEmail andPassword:userPassword forServiceName:serviceName updateExisting:TRUE error:&error];
            
            //store user data in singleton
            PVSingletonData *singletonData = [PVSingletonData sharedID];
            NSDictionary *userData = [jsonArray objectAtIndex:0];
            singletonData.userID = [userData objectForKey:@"_id"];
            userID = singletonData.userID;
            singletonData.userDisplayName = [userData objectForKey:@"display_name"];
            singletonData.userEmail = [userData objectForKey:@"email"];
            singletonData.portfileID = [userData objectForKey:@"portfile_id"];
            [self getUserInfo];
        }
    }
}

-(void)getUserInfo
{
    //send URL request to authenticate login
    NSString *urlString = [NSString stringWithFormat:@"http://guarded-tor-3762.herokuapp.com/portfiles.json?userid=%@", userID];
    NSURL *webURL = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:webURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSError *error;

    NSURLResponse *response;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (returnData)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        NSError* error;
        //parse json
        NSArray *jsonArray = [NSJSONSerialization
                              JSONObjectWithData:returnData
                              options:kNilOptions
                              error:&error];
        //on success
        if (TRUE)
        {
            //store user data in singleton
            PVSingletonData *singletonData = [PVSingletonData sharedID];
            NSDictionary *userData = [jsonArray objectAtIndex:0];
            singletonData.rep = [userData objectForKey:@"reputation"];
            singletonData.isLoggedIn = YES;
            
            PVAppDelegate *appDelegate = (PVAppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:appDelegate.tabBarController menuViewController:appDelegate.menuTableViewController];
            [[[[appDelegate.tabBarController tabBar]items]objectAtIndex:0]setEnabled:TRUE];
            [[[[appDelegate.tabBarController tabBar]items]objectAtIndex:3]setEnabled:TRUE];
            [appDelegate.tabBarController setSelectedIndex:0];
            [appDelegate.window setRootViewController:appDelegate.frostedViewController];
            [appDelegate.window makeKeyAndVisible];
        }
        else
        {
            // Create and show an alert view with this error displayed
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:@"An error retrieving your information occurred.  Please try connecting again."
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
            [av show];
        }
    }
}

@end
