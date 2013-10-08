//
//  SearchVC.h
//  w2connect
//
//  Created by Anna Billstrom on 10/7/13.
//  Copyright (c) 2013 Anna Billstrom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchVC : UIViewController <UIWebViewDelegate>{
    IBOutlet UIWebView *webView;
}

@property IBOutlet UIWebView *webView;

-(void)backToAttending:(id)sender;

@end
