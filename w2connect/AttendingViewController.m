//
//  AttendingViewController.m
//  w2connect
//
//  Created by Anna Billstrom on 9/28/13.
//  Copyright (c) 2013 Anna Billstrom. All rights reserved.
//

#import "AttendingViewController.h"
#import "ProfileVC.h"
#import "SearchVC.h"
#import "Constants.h"
#import "User.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "wizard1VC.h"

@implementation AttendingViewController
@synthesize webView, alertView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Attending" image:[UIImage imageNamed:@"attendeelist"] tag:1];
        

    }
    
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [self userChecks];
    
    [self drawWebView];

}

-(void)userChecks{
    [self checkUserLogin];
    if([[User instance] isValidToken]){
        [self checkForProfileCompleteness];
    }
}


-(void)checkUserLogin{
    if([[User instance] needsLogin] == YES){
        LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginView_iPhone" bundle:nil];
        [self presentModalViewController:loginVC animated:YES];
    }
}


- (void)viewDidLoad
{

    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveUpsellNotification:)
                                                 name:@"UpsellNotification"
                                               object:nil];
}

-(void)checkForProfileCompleteness{
    if([[User instance] hasNoPhoto] == YES) {
        
        UITabBarController *MyTabController = (UITabBarController *)((AppDelegate*) [[UIApplication sharedApplication] delegate]).window.rootViewController;
        [MyTabController setSelectedIndex:0];

    }
}

-(void)drawWebView{
    
    if([[User instance] isValidToken] == YES){
        
        NSString *stringUrl = [NSString stringWithFormat:@"%@/api/v1/people?auth_token=%@",kAPIBaseURLString,[[User instance] token]];
        NSURL *url = [[NSURL alloc] initWithString:stringUrl];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [self.webView loadRequest:request];
    }
}
- (void) receiveUpsellNotification:(NSNotification *) notification
{
   
    
    if ([[notification name] isEqualToString:@"UpsellNotification"]){
        NSLog (@"Successfully received the upsell notification!");
        [self checkForUpsell];
    }
    
}

-(void)viewProfile:(id)sender{
    ProfileVC *profileVC = [[ProfileVC alloc] initWithNibName:@"ProfileVC" bundle:nil];
    [[self navigationController] pushViewController:profileVC animated:NO];

}

-(void)viewSearch:(id)sender{
    SearchVC *searchVC = [[SearchVC alloc] initWithNibName:@"SearchVC" bundle:nil];
    [[self navigationController] pushViewController:searchVC animated:NO];

}

- (void)displayUpsellAlert {
    self.alertView = [[UIAlertView alloc] initWithTitle:@"Join Women2.0"
                                                message:@"Find out about the perks of membershiip"
                                               delegate:self
                                      cancelButtonTitle:@"Cancel"
                                      otherButtonTitles:@"OK", nil];
    [self.alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSLog(@"in did click");
    
    if(buttonIndex == 1){
        // do flurry notification
        NSString* launchUrl = @"http://www.formstack.com/forms/?1508882-wO8PffbV8E";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];
        NSLog(@"in buttonindex 1");
    } else {
        NSLog(@"in buttonindex 0");
        // do flurry notification
    }
}

-(void)checkForUpsell{
    NSLog(@"check for upsell");
    if([[User instance] numTimesLogin] == 2){
        // launch alert
        NSLog(@"valid for upsell- %d", [[User instance] numTimesLogin]);
        [self displayUpsellAlert];
    }
}




@end
