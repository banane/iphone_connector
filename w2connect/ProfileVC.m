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
                                   initWithTitle:@"Photo"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(launchPhoto:)];
    self.navigationItem.leftBarButtonItem = photoBtn;
    
    UIBarButtonItem *backToAttending = [[UIBarButtonItem alloc]
                                  initWithTitle:@"Attending"
                                  style:UIBarButtonItemStyleBordered
                                  target:self
                                  action:@selector(backToAttending:)];
    self.navigationItem.rightBarButtonItem = backToAttending;
    
    /* get uid from app */
    NSString *stringUrl = [NSString stringWithFormat:@"%@/api/v1/people/%@/edit",kAPIBaseURLString, [[User instance] UID]];
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
    [[self navigationController] popViewControllerAnimated:NO];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
