//
//  AppDelegate.m
//  w2connect
//
//  Created by Anna Billstrom on 9/28/13.
//  Copyright (c) 2013 Anna Billstrom. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworking.h>
#import "TestFlight.h"
#import "User.h"
#import "ProfileVC.h"
#import "SearchVC.h"
#import "AttendingViewController.h"
#import "LoginViewController.h"
#import "Constants.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"in app launch");
    [[User instance] loadFromDefaults];
    
    NSLog(@"token: %@", [[User instance] token]);
    
    self.tabCtrl = [[UITabBarController alloc] initWithNibName:nil bundle:nil];
    self.tabCtrl.delegate = self;

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AttendingViewController *attVC = [[AttendingViewController alloc] initWithNibName:@"Attending_iPhone" bundle:nil];

    ProfileVC *pVC = [[ProfileVC alloc] initWithNibName:@"ProfileVC" bundle:nil];

    SearchVC *sVC = [[SearchVC alloc] initWithNibName:@"SearchVC" bundle:nil];
    
    UINavigationController *pNavCtrl = [[UINavigationController alloc] initWithRootViewController:pVC];
 
    self.window.rootViewController = self.tabCtrl;
    
    self.tabCtrl.viewControllers = [[NSArray alloc] initWithObjects:pNavCtrl, attVC, sVC, nil];
    self.tabCtrl.selectedIndex = 1;
    
    [TestFlight takeOff:testFlightToken];


    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    
    
}



- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[User instance] saveToDefaults];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
     [[User instance] loadFromDefaults];
     [[NSUserDefaults standardUserDefaults] synchronize];
}



- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"in app active");

    [[User instance] incrementVisit];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"UpsellNotification"
     object:self];
    NSLog(@"%d number of times visited", [[User instance] numTimesLogin]);
   
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    NSLog(@"in did select vc");
    if(self.tabCtrl.selectedIndex == 1){
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"RefreshAttendeeListNotification"
         object:self];
        NSLog(@"time to refresh view");
    }
    
}


@end
