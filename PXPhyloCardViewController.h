//
//  PXPhyloCardViewController.h
//  Phylodex
//
//  Created by ParkaPal on 2013-07-25.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCropper.h"
#import "Phylodex.h"
#import "Photo.h"
#import "PXEditCardViewController.h"

@interface PXPhyloCardViewController : UIViewController<UIGestureRecognizerDelegate, ImageCropperDelegate>

@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *sciname_label;

@property (weak, nonatomic) IBOutlet UIImageView *size_img;
@property (weak, nonatomic) IBOutlet UIImageView *diet_img;

@property (copy, nonatomic) UIImage *image; //temp image storage to fix crop refresh lag
@property (strong, nonatomic) IBOutlet UIImageView *phyloCardImage;

@property (weak, nonatomic) IBOutlet UILabel *points_label;
@property (weak, nonatomic) IBOutlet UILabel *climates_label;
@property (weak, nonatomic) IBOutlet UILabel *classification_label;


@property (nonatomic, retain) Phylodex *phyloElement;


@end
