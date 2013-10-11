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

@implementation PhotoVC
@synthesize imageView, descriptionLabel, photoBtn, fromWizard;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // load image if it's there
        
        self.title = @"Add Photo";
    }
    return self;
}

- (void)viewDidLoad{
    
}

-(IBAction)takePhoto:(id)sender{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    /* TODO:  upload to s3 */
    [self loadProfile];
    
}

-(void)loadProfile{
    ProfileVC *pvc = [[ProfileVC alloc] initWithNibName:@"ProfileVC" bundle:nil];
    [[self navigationController] pushViewController:pvc animated:NO];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
