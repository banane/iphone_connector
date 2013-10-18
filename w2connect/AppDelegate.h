//
//  AppDelegate.h
//  w2connect
//
//  Created by Anna Billstrom on 9/28/13.
//  Copyright (c) 2013 Anna Billstrom. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate> {
    bool skipLogin;
}

@property (strong, nonatomic) UIWindow *window;
//@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UITabBarController *tabCtrl;

- (bool)isUserTokenValid;
- (bool)shouldUserLogin;


@end
