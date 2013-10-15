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

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginView_iPhone" bundle:nil];
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self.window addSubview:self.navigationController.view];
    self.navigationController.navigationBar.hidden = YES;
//    [TestFlight setDeviceIdentifier:[[UIDevice currentDevice] uniqueIdentifier]];
    [TestFlight takeOff:@"75456710-2e74-46c0-a034-57293f61079e"];
 //   self.window.rootViewController = loginVC;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[User instance] saveToDefaults];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[User instance] loadFromDefaults];
    [[User instance] incrementVisit];
    NSLog(@"%d number of times visited", [[User instance] numTimesLogin]);
   
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
