//
//  ProfileVC.h
//  w2connect
//
//  Created by Anna Billstrom on 10/7/13.
//  Copyright (c) 2013 Anna Billstrom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileVC : UIViewController <UIWebViewDelegate>{
    IBOutlet UIWebView *webView;
}

@property (nonatomic, strong) IBOutlet UIWebView *webView;

-(void)launchPhoto:(id)sender;

-(void)drawWebView;

@end
