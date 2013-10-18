//
//  previewVC.h
//  connector
//
//  Created by Anna Billstrom on 10/18/13.
//  Copyright (c) 2013 Anna Billstrom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface previewVC : UIViewController <UIWebViewDelegate>{
    IBOutlet UIWebView *webView;
}

@property (nonatomic, strong) IBOutlet UIWebView *webView;

-(void)drawWebView;

@end
