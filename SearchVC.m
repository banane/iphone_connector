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
    }
    return self;
}

- (void)viewDidLoad
{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *attendingBtn = [[UIBarButtonItem alloc]
                                 initWithTitle:@"Attending"
                                 style:UIBarButtonItemStyleBordered
                                 target:self
                                 action:@selector(backToAttending:)];
    self.navigationItem.leftBarButtonItem = attendingBtn;
    
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
