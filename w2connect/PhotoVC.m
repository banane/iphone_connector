//
//  PhotoVC.m
//  connector
//
//  Created by Anna Billstrom on 10/8/13.
//  Copyright (c) 2013 Anna Billstrom. All rights reserved.
//

#import "PhotoVC.h"
#import "ProfileVC.h"
#import "User.h"
#import <AWSS3/AWSS3.h>
#import "connectClient.h"
#import <AFNetworking.h>
#include <stdlib.h>
#include "Constants.h"
#include "wizard1VC.h"


@implementation PhotoVC
@synthesize imageView, descriptionLabel, photoBtn,counter;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // load image if it's there
        
        self.title = @"Add Photo";
        self.counter = 0;
    }
    return self;
}

- (void)viewDidLoad{
    
   
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.hidesBackButton = YES;
    
    
    
    if([[User instance] hasNoPhoto] == NO){                        /// anon users can't click profile
        UIBarButtonItem *profileBtn = [[UIBarButtonItem alloc]
                                       initWithImage:[UIImage imageNamed:@"profile"]
                                       style:UIBarButtonItemStyleBordered
                                       target:self
                                       action:@selector(backToProfile:)];
        self.navigationItem.rightBarButtonItem = profileBtn;
    }
    [self.tabBarController.tabBar setHidden:YES];
    
   
     [super viewDidLoad];
   
}

-(IBAction)backToProfile:(id)sender{
    [[self navigationController] popToRootViewControllerAnimated:NO];
}


-(void)viewDidAppear:(BOOL)animated {
    if([[User instance] hasNoPhoto] && counter == 0){
        wizard1VC *wVC = [[wizard1VC alloc] initWithNibName:@"wizard1VC" bundle:nil];
        [self presentModalViewController:wVC animated:NO];
        
    }
    counter += 1; // to make sure wizard just shows once
}

-(IBAction)takePhoto:(id)sender{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

-(void)uploadImageToAWS:(UIImage *)image {
    
    int randomNum = arc4random() % 10000;
    NSString *imageKeyName = [NSString stringWithFormat:@"profile_%d_%d.png",[[User instance] UID], randomNum];
    NSString *imageBucketName = @"mobileprofiles";

    
    AmazonS3Client *s3 = [[AmazonS3Client alloc] initWithAccessKey:kAWSPublicAccessKey
                                                     withSecretKey:kAWSSecretKey];
    S3PutObjectRequest *por = [[S3PutObjectRequest alloc] initWithKey:imageKeyName inBucket:imageBucketName];
    por.contentType = @"image/jpeg";
    NSData *imageData = UIImagePNGRepresentation(image);
    por.data = imageData;
     por.cannedACL   = [S3CannedACL publicRead];
    [s3 putObject:por];

    S3ResponseHeaderOverrides *override = [[S3ResponseHeaderOverrides alloc] init];
    override.contentType = @"image/png";
    S3GetPreSignedURLRequest *gpsur = [[S3GetPreSignedURLRequest alloc] init] ;
    gpsur.key     = imageKeyName;
    gpsur.bucket  = imageBucketName;
    int seconds = 3600 * 24 * 365;
    gpsur.expires = [NSDate dateWithTimeIntervalSinceNow:(NSTimeInterval) seconds];
    gpsur.responseHeaderOverrides = override;
    NSURL *url = [s3 getPreSignedURL:gpsur];
    NSString *urlString = [url absoluteString];
    [self postToServer:urlString];
    
}
- (void)postToServer:(NSString *)profileUrlString{
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:profileUrlString, @"profile_photo",[[User instance] token], @"auth_token", nil];
    connectClient *client = [connectClient sharedClient];
    NSString *path = [NSString stringWithFormat:@"/api/v1/people/%d.json", [[User instance] UID]];
    
    NSURLRequest* request = [client requestWithMethod:@"PUT" path:path parameters:params];
    
    AFJSONRequestOperation* operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        // 6 - Request succeeded block
        NSLog(@"profile photo upload response from json: %@", JSON);
        NSDictionary *params = JSON;
        
        [[User instance ] saveProfilePhoto:params[@"profile_photo"]];
    
        [[self navigationController] popToRootViewControllerAnimated:NO];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"failure to post photo");
    }];

    [operation start];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
  //  self.imageView.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    chosenImage = [self reduceSize:chosenImage];
    [self uploadImageToAWS:chosenImage];
    
}

-(UIImage *) reduceSize:(UIImage *) image {
    UIGraphicsBeginImageContext(CGSizeMake(200,200));
    
    CGContextRef  *context = UIGraphicsGetCurrentContext();
    
    [image drawInRect: CGRectMake(0, 0, 200, 200)];
    
    UIImage  *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return smallImage;
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
