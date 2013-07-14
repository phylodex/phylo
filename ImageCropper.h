//
//  ImageCropper.h
//  Created by http://github.com/iosdeveloper
//

#import <UIKit/UIKit.h>
//#import "PXDetailViewController.h"


@class PXDetailViewController;

@protocol ImageCropperDelegate;


@interface ImageCropper : UIViewController {
	UIScrollView *scrollView;
	UIImageView *imageView;
	PXDetailViewController *parent;
    
	id <ImageCropperDelegate> delegate;
}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIImageView *imageView;

@property (nonatomic, retain) id <ImageCropperDelegate> delegate;

@property (strong, nonatomic) PXDetailViewController *parent;


- (id)initWithImage:(UIImage *)image;

@end

@protocol ImageCropperDelegate <NSObject>

- (void)imageCropper:(ImageCropper *)cropper didFinishCroppingWithImage:(UIImage *)image;
- (void)imageCropperDidCancel:(ImageCropper *)cropper;

@end
