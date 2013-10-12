//
//  ProfileVC.m
//  w2connect
//
//  Created by Anna Billstrom on 10/7/13.
//  Copyright (c) 2013 Anna Billstrom. All rights reserved.
//

#import "ProfileVC.h"
#import "User.h"
#import "Constants.h"
#import "PhotoVC.h"
#import "AttendingViewController.h"

@interface ProfileVC ()

@end

@implementation ProfileVC

@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    self.title = @"Profile";
    return self;
}

- (void)viewDidLoad
{
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *photoBtn = [[UIBarButtonItem alloc]
                                   initWithImage:[UIImage imageNamed:@"photo"]
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(launchPhoto:)];
    self.navigationItem.leftBarButtonItem = photoBtn;
    
    UIBarButtonItem *backToAttending = [[UIBarButtonItem alloc]
                                  initWithImage:[UIImage imageNamed:@"attendeelist"]
                                  style:UIBarButtonItemStyleBordered
                                  target:self
                                  action:@selector(backToAttending:)];
    self.navigationItem.rightBarButtonItem = backToAttending;
    
    /* get uid from app */
    NSString *stringUrl = [NSString stringWithFormat:@"%@/api/v1/people/%@/edit?auth_token=%@",kAPIBaseURLString, [[User instance] UID], [[User instance] token]];
    NSURL *url = [[NSURL alloc] initWithString:stringUrl];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)launchPhoto:(id)sender{
    PhotoVC *photoVC = [[PhotoVC alloc] initWithNibName:@"PhotoVC" bundle:nil];
    [[self navigationController] pushViewController:photoVC animated:NO];
    
}

-(void)backToAttending:(id)sender{
    // check if attending is next
    AttendingViewController *attVC = [[AttendingViewController alloc] initWithNibName:@"Attending_iPhone" bundle:nil];
    if([[[self navigationController] viewControllers] containsObject:attVC]){
        [[self navigationController] popViewControllerAnimated:NO];
    } else {
        [[self navigationController] pushViewController:attVC animated:NO];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
