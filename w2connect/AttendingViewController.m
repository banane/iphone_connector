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

@implementation AttendingViewController
@synthesize webView, alertView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Women 2.0", @"Women 2.0");
    }
    
    return self;
}



- (void)viewDidLoad
{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *profileBtn = [[UIBarButtonItem alloc]
                                initWithImage:[UIImage imageNamed:@"profile"]
                                style:UIBarButtonItemStyleBordered
                                target:self
                                action:@selector(viewProfile:)
                                ];
    self.navigationItem.leftBarButtonItem = profileBtn;
    
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc]
                                  initWithImage:[UIImage imageNamed:@"search"]
                                  style:UIBarButtonItemStyleBordered
                                  target:self
                                  action:@selector(viewSearch:)];
    self.navigationItem.rightBarButtonItem = searchBtn;
    
    NSString *stringUrl = [NSString stringWithFormat:@"%@/api/v1/people?auth_token=%@",kAPIBaseURLString,[[User instance] token]];
    NSURL *url = [[NSURL alloc] initWithString:stringUrl];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveUpsellNotification:)
                                                 name:@"UpsellNotification"
                                               object:nil];
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
        NSString* launchUrl = @"http://www.women2.com/membership";
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
