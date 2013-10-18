//
//  previewVC.m
//  connector
//
//  Created by Anna Billstrom on 10/18/13.
//  Copyright (c) 2013 Anna Billstrom. All rights reserved.
//

#import "previewVC.h"
#import "User.h"
#import "Constants.h"

@interface previewVC ()

@end

@implementation previewVC

@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    [self drawWebView];
}

-(void)drawWebView{
    if([[User instance] isValidToken]){
        NSString *stringUrl = [NSString stringWithFormat:@"%@/api/v1/people/%d?auth_token=%@",kAPIBaseURLString, [[User instance] UID], [[User instance] token]];
        NSURL *url = [[NSURL alloc] initWithString:stringUrl];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [self.webView loadRequest:request];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
