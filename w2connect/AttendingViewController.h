//
//  AttendingTabsViewController.h
//  w2connect
//
//  Created by Anna Billstrom on 9/28/13.
//  Copyright (c) 2013 Anna Billstrom. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface AttendingViewController : UIViewController <UIWebViewDelegate, UIAlertViewDelegate, UITabBarControllerDelegate> {
    UIWebView *webView;
    UIAlertView *alertView;

}

@property IBOutlet UIWebView *webView;
@property UIAlertView *alertView;
-(void)viewProfile:(id)sender;

-(void)viewSearch:(id)sender;
-(void)checkForUpsell;
-(void)displayUpsellAlert;
-(void)drawWebView;


@end
