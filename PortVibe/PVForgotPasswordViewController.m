//
//  PVForgotPasswordViewController.m
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import "PVForgotPasswordViewController.h"
#import "PVAppDelegate.h"

@implementation PVForgotPasswordViewController
@synthesize email;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self.navigationItem setTitle:@"Forgot Info"];
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
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [email resignFirstResponder];
    return YES;
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"Connection received output");
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
    NSLog(@"Connection is receiving data.");
    //As data is coming in, network indicator is turned on
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)conn
{
    //finished loading, turn network indicator off
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    NSLog(@"Success! Received %d bytes of data.", [receivedData length]);
    NSError* error;
    
    //parse json
    NSArray *jsonArray  = [NSJSONSerialization
                           JSONObjectWithData:receivedData
                           options:kNilOptions
                           error:&error];
    
    //NSString *printString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    //NSLog(@"%@", printString);
    
    for (NSDictionary *jsonDictionaryElement in jsonArray)
    {
        for (id key in jsonDictionaryElement)
        {
            NSLog(@"key=%@  value=%@", key, [jsonDictionaryElement objectForKey:key]);
        }
    }
    //reset connection and data received
    connection = nil;
    receivedData = nil;
}

- (void)connection:(NSURLConnection *)conn
  didFailWithError:(NSError *)error
{
    // Release the connection object, we're done with it
    connection = nil;
    receivedData = nil;
    
    // Grab the description of the error object passed to us
    NSString *errorString = [NSString stringWithFormat:@"Connection Failure: %@",
                             [error localizedDescription]];
    
    // Create and show an alert view with this error displayed
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error"
                                                 message:errorString
                                                delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
    [av show];
}

-(IBAction)sendButton:(id)sender
{
    if (email.text.length > 5)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
        //send URL request to authenticate login
        NSString *urlString = @"http://guarded-tor-3762.herokuapp.com/forgotpassword.json";
        
        // Create a new data container for the stuff that comes back from the service
        receivedData = [NSMutableData dataWithCapacity:0];
        
        // Construct a URL that will ask the service for what you want -
        // note we can concatenate literal strings together on multiple
        // lines in this way - this results in a single NSString instance
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        // Convert your data and set your request's HTTPBody property
        NSDictionary *loginData = [NSDictionary
                                   dictionaryWithObjectsAndKeys: email.text, @"email",
                                   nil];
        NSError * error = nil;
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:loginData
                                                           options:NSJSONWritingPrettyPrinted error:&error];
        request.HTTPBody = jsonData;
        
        // Create a connection that will exchange this request for data from the URL
        connection = [[NSURLConnection alloc] initWithRequest:request
                                                     delegate:self
                                             startImmediately:YES];
    }
}

@end
