//
//  PhotoVC.h
//  connector
//
//  Created by Anna Billstrom on 10/8/13.
//  Copyright (c) 2013 Anna Billstrom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoVC : UIViewController <UIImagePickerControllerDelegate>{
    IBOutlet UIImageView *imageView;
    IBOutlet UILabel *descriptionLabel;
    IBOutlet UIButton *photoBtn;
    int counter;
}


@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) IBOutlet UIButton *photoBtn;
@property int counter;


-(IBAction)takePhoto:(id)sender;
-(void) uploadImageToAWS:chosenImage;
-(void)postToServer:(NSString *)profileUrlString;
-(UIImage *) reduceSize:(UIImage *) image;
-(IBAction)backToProfile:(id)sender;

@end
