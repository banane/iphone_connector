//
//  LoginViewController.m
//  w2connect
//
//  Created by Anna Billstrom on 9/28/13.
//  Copyright (c) 2013 Anna Billstrom. All rights reserved.
//


#import "LoginViewController.h"
#import "AttendingViewController.h"
#import "connectClient.h"
#import <AFNetworking.h>
#import "ProfileVC.h"
#import "User.h"
#import "wizard1VC.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize email, accessLabel, regLabel, errors;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Login", @"Login");
       
    }
    return self;
}

- (void)viewDidLoad
{
    UIFont *customFont = [UIFont fontWithName:@"Lato-Bol" size:18.0f];

    
    self.accessLabel.font = customFont;

    UIFont *smCustomFont = [UIFont fontWithName:@"Lato-Bol" size:18.0f];
    self.regLabel.font = smCustomFont;
 
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)login:(id)sender{
     [self.email resignFirstResponder];
    
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:self.email.text, @"email", nil];
    connectClient *client = [connectClient sharedClient];
    NSString *path = @"/api/v1/tokens.json";

    NSURLRequest* request = [client requestWithMethod:@"POST" path:path parameters:params];
    
    AFJSONRequestOperation* operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        // 6 - Request succeeded block
        NSLog(@"response from json: %@", JSON);
        NSDictionary *params = JSON;
        
        [[User instance ] saveUser:params email:self.email.text];
        
        [self dismissModalViewControllerAnimated:YES];

        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        self.errors.text = @"Unable to log you in for this event.";
        NSLog(@"failure to login");
        // 7 - Request failed block
    }];
    // 8 - Start request
    [operation start];
    // go to server and get login state, redir

}

- (IBAction)viewEventListing:(id)sender{

    connectClient *client = [connectClient sharedClient];
    NSString *path = @"/api/v1/logins/event_info.json";
    
    NSURLRequest* request = [client requestWithMethod:@"GET" path:path parameters:nil];
    
    AFJSONRequestOperation* operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        // 6 - Request succeeded block
        NSLog(@"response from json: %@", JSON);
        NSDictionary *params = JSON;
        
        NSString *urlString = params[@"link"];
    
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        self.errors.text = @"Event not found.";
        NSLog(@"failure to get event link");
        // 7 - Request failed block
    }];
    // 8 - Start request
    [operation start];
    
    
    
    
}


@end
