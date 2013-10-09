//
//  wizard1VC.m
//  connector
//
//  Created by Anna Billstrom on 10/8/13.
//  Copyright (c) 2013 Anna Billstrom. All rights reserved.
//

#import "wizard1VC.h"
#import "PhotoVC.h"

@interface wizard1VC ()

@end

@implementation wizard1VC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

-(IBAction)viewPhoto:(id)sender{
    PhotoVC *pvc = [[PhotoVC alloc] initWithNibName:@"PhotoVC" bundle:nil];
    [[self navigationController] pushViewController:pvc animated:NO];
}
@end
