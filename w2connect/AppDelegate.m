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
    NSLog(@"in app launch");
    [[User instance] loadFromDefaults];
    

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    if([self isUserTokenValid] && ([[User instance] UID] > 0)){  // has logged in before and is valid

        AttendingViewController *attVC = [[AttendingViewController alloc] initWithNibName:@"Attending_iPhone" bundle:nil];
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:attVC];
    
    } else {
        LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginView_iPhone" bundle:nil];
        
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:loginVC];
    }
        
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
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

- (bool)isUserTokenValid{
    bool result_value = NO;
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    
    //Calculates the date of tomorrow:
    NSDate *expiresDate = [[[User instance] lastLoginDate] addTimeInterval: (secondsPerDay+secondsPerDay)];
    NSDate *today = [NSDate date];
    NSComparisonResult result = [expiresDate compare:today];
    
    if(result==NSOrderedAscending){
        NSLog(@"Date1 is in the future");
        result_value = YES;
    } else if(result==NSOrderedDescending) {
        NSLog(@"Date1 is in the past");
        result_value = NO;
    } else {
        result_value = NO;
        NSLog(@"Both dates are the same");
    }
    return result_value;
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
    NSLog(@"in app active");
//    [[User instance] loadFromDefaults];
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



@end
