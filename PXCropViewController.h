//
//  PXCropViewController.h
//  Phylodex
//
//  Created by Artha on 13-7-4.
//  Copyright (c) 2013年 Phylosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCropper.h"
@interface PXCropViewController : UIViewController<ImageCropperDelegate>{
	UIImageView *imageView;
}

@property (nonatomic, retain) UIImageView *imageView;



@end
