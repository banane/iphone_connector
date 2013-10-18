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
#include "wizard1VC.h"
#include "previewVC.h"

@interface ProfileVC ()

@end

@implementation ProfileVC

@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:[UIImage imageNamed:@"profile"] tag:0];

    }
    self.title = @"Profile";
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];

    
    [self checkForWizard];
    [self drawWebView];
}

-(void)checkForWizard{
    if([[User instance] hasNoPhoto] == YES){
        
        PhotoVC *pvc = [[PhotoVC alloc] initWithNibName:@"PhotoVC" bundle:nil];
        [[self navigationController] pushViewController:pvc animated:NO];
    }

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
    
    UIBarButtonItem *previewBtn = [[UIBarButtonItem alloc]
                                // initWithImage:[UIImage imageNamed:@"ProfileView"]
                                 initWithTitle:@"Preview"
                                 style:UIBarButtonItemStyleBordered
                                 target:self
                                 action:@selector(launchPreview:)];
    self.navigationItem.rightBarButtonItem = previewBtn;

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

-(IBAction)launchPreview:(id)sender{
    previewVC *pvc = [[previewVC alloc] initWithNibName:@"previewVC" bundle:nil];
    [[self navigationController] pushViewController:pvc animated:NO];
    
}


-(void)drawWebView{
    if([[User instance] isValidToken]){
        NSString *stringUrl = [NSString stringWithFormat:@"%@/api/v1/people/%d/edit?auth_token=%@",kAPIBaseURLString, [[User instance] UID], [[User instance] token]];
        NSURL *url = [[NSURL alloc] initWithString:stringUrl];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [self.webView loadRequest:request];
    }

}


-(void)launchPhoto:(id)sender{
    PhotoVC *photoVC = [[PhotoVC alloc] initWithNibName:@"PhotoVC" bundle:nil];
    [[self navigationController] pushViewController:photoVC animated:NO];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
