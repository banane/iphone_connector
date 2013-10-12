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

@synthesize email, accessLabel, regLabel;

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

- (IBAction)login:(id)sender{
    
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:self.email.text, @"email", nil];
    connectClient *client = [connectClient sharedClient];
    NSString *path = @"/api/v1/tokens.json";

    NSURLRequest* request = [client requestWithMethod:@"POST" path:path parameters:params];
    
    AFJSONRequestOperation* operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        // 6 - Request succeeded block
        NSLog(@"response from json: %@", JSON);
        NSDictionary *params = JSON;
        
        [[User instance ] saveUser:params email:self.email.text];
        
        [self determineNextView];
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"failure to login");
        // 7 - Request failed block
    }];
    // 8 - Start request
    [operation start];
    // go to server and get login state, redir

}

- (IBAction)viewEventListing:(id)sender{

        // access women2 site in safari
}

-(void)determineNextView{
    // may move this ahead if they don't have to log in
 /*   if([[User instance] numTimesLogin] <= 1){
        [self startWizard];
    } else if([[[User instance] profilePhoto] length] == 0){
        [self startWizard];
    } else {*/
        [self loadAttending];
//    }
}

- (void)loadAttending{
    
    /* check if first time, route to wizard, else: */
    AttendingViewController *attVC = [[AttendingViewController alloc] initWithNibName:@"Attending_iPhone" bundle:nil];
    [[self navigationController] pushViewController:attVC animated:NO];

    
}
-(void)startWizard{
    wizard1VC *wvc = [[wizard1VC alloc] initWithNibName:@"wizard1VC" bundle:nil];
    [[self navigationController] pushViewController:wvc animated:NO];
}



@end
