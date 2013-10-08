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

@implementation AttendingViewController
@synthesize webView;


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
                                initWithTitle:@"Profile"
                                style:UIBarButtonItemStyleBordered
                                target:self
                                action:@selector(viewProfile:)];
    self.navigationItem.leftBarButtonItem = profileBtn;
    
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc]
                                  initWithTitle:@"Search"
                                  style:UIBarButtonItemStyleBordered
                                  target:self
                                  action:@selector(viewSearch:)];
    self.navigationItem.rightBarButtonItem = searchBtn;
    
    NSString *stringUrl = [NSString stringWithFormat:@"%@/api/v1/people",kAPIBaseURLString];
    NSURL *url = [[NSURL alloc] initWithString:stringUrl];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    [super viewDidLoad];
}

-(void)viewProfile:(id)sender{
    ProfileVC *profileVC = [[ProfileVC alloc] initWithNibName:@"ProfileVC" bundle:nil];
    [[self navigationController] pushViewController:profileVC animated:NO];

}

-(void)viewSearch:(id)sender{
    SearchVC *searchVC = [[SearchVC alloc] initWithNibName:@"SearchVC" bundle:nil];
    [[self navigationController] pushViewController:searchVC animated:NO];

}
    


@end
