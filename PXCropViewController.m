//
//  PXCropViewController.m
//  Phylodex
//
//  Created by Artha on 13-7-4.
//  Copyright (c) 2013年 Phylosoft. All rights reserved.
//

#import "PXCropViewController.h"

@interface PXCropViewController ()

@end

@implementation PXCropViewController
@synthesize imageView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [imageView setFrame:CGRectMake(80.0, 20.0, 320.0, 230.0)];
	[imageView setContentMode:UIViewContentModeScaleAspectFit];
	
	[[self view] addSubview:imageView];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button addTarget:self action:@selector(cropImage) forControlEvents:UIControlEventTouchUpInside];
	[button setFrame:CGRectMake(124.0, 258.0, 72.0, 37.0)];
	[button setTitle:@"Crop!" forState:UIControlStateNormal];
	
	[[self view] addSubview:button];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*

- (void)loadView {
	[super loadView];
	
	imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SteveJobsMacbookAir.JPG"]];
	[imageView setFrame:CGRectMake(80.0, 20.0, 320.0, 230.0)];
	[imageView setContentMode:UIViewContentModeScaleAspectFit];
	
	[[self view] addSubview:imageView];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button addTarget:self action:@selector(cropImage) forControlEvents:UIControlEventTouchUpInside];
	[button setFrame:CGRectMake(124.0, 258.0, 72.0, 37.0)];
	[button setTitle:@"Crop!" forState:UIControlStateNormal];
	
	[[self view] addSubview:button];
}*/
/*
- (void)cropImage {
	ImageCropper *cropper = [[ImageCropper alloc] initWithImage:[imageView image]];
	[cropper setDelegate:self];
	
	[self presentModalViewController:cropper animated:YES];
	
    //	[cropper release];
}*/

- (void)imageCropper:(ImageCropper *)cropper didFinishCroppingWithImage:(UIImage *)image {
	[imageView setImage:image];
	
	[self dismissModalViewControllerAnimated:YES];
	
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)imageCropperDidCancel:(ImageCropper *)cropper {
	[self dismissModalViewControllerAnimated:YES];
	
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}



@end
