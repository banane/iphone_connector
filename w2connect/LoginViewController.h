//
//  LoginViewController.h
//  w2connect
//
//  Created by Anna Billstrom on 9/28/13.
//  Copyright (c) 2013 Anna Billstrom. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <AFHTTPClient.h>
#import <AFJSONRequestOperation.h>

extern NSString * const kBaseURLString;


@interface LoginViewController : UIViewController <UITextFieldDelegate> {
    UITextField *email;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *accessLabel;
    IBOutlet UILabel *regLabel;
    
}

@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *accessLabel;
@property (strong, nonatomic) IBOutlet UILabel *regLabel;


-(IBAction)viewEventListing:(id)sender;
-(IBAction)login:(id)sender;
-(void)determineNextView;
-(void)loadAttending;
-(void)startWizard;





@end
