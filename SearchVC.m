//
//  SearchVC.m
//  w2connect
//
//  Created by Anna Billstrom on 10/7/13.
//  Copyright (c) 2013 Anna Billstrom. All rights reserved.
//

#import "SearchVC.h"
#import "Constants.h"
#import "User.h"

@interface SearchVC ()

@end

@implementation SearchVC
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Search";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Search" image:[UIImage imageNamed:@"search"] tag:1];
        
    }
    return self;
}

- (void)viewDidLoad
{

    
    NSString *stringUrl = [NSString stringWithFormat:@"%@/api/v1/search?auth_token=%@", kAPIBaseURLString, [[User instance] token]];
    NSURL *url = [[NSURL alloc] initWithString:stringUrl];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
