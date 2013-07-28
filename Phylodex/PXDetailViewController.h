//
//  PXDetailViewController.h
//  Phylodex
//
//  Created by Steve King on 2013-06-24.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//
//
//  ImageCropper.h
//  Created by http://github.com/iosdeveloper
//


#import <UIKit/UIKit.h>
#import "ImageCropper.h"

@class PXDetailViewController;
@class Phylodex;
@class Photo;

@protocol PXDetailViewControllerDelegate;

@interface PXDetailViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate,ImageCropperDelegate>{
    IBOutlet UIScrollView *scroller;
    IBOutlet UIScrollView *scrollerView;
    UIImageView *imageView;
    Phylodex *phyloElement;
    Photo *photoElement;
}

@property (nonatomic, assign)id <PXDetailViewControllerDelegate>delegate;

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UIImage *image;
@property (nonatomic, retain) UIBarButtonItem *saveButton;

@property (nonatomic, retain) Phylodex *phyloELement;
@property (nonatomic, retain) Photo *photoElement;

@property (strong, nonatomic) IBOutlet UITextField *nameOfCreature;
@property (strong, nonatomic) IBOutlet UITextField *habitatType;
@property (strong, nonatomic) IBOutlet UITextField *artistInfo;
@property (strong, nonatomic) IBOutlet UITextField *climate;
@property (strong, nonatomic) IBOutlet UITextField *climate2;
@property (strong, nonatomic) IBOutlet UITextField *climate3;
@property (strong, nonatomic) IBOutlet UITextField *terrain;
@property (strong, nonatomic) IBOutlet UITextField *terrain2;
@property (strong, nonatomic) IBOutlet UITextView *desc;

@property (strong, nonatomic) IBOutlet UILabel *displayLabel;
@property (strong, nonatomic) IBOutlet UILabel *pointValue;
@property (strong, nonatomic) IBOutlet UILabel *foodChain;
@property (strong, nonatomic) IBOutlet UILabel *scaleNumber;
@property (strong, nonatomic) IBOutlet UIImageView *pointColor;

@property (weak, nonatomic) IBOutlet UISegmentedControl *creature_kingdom;
@property (weak, nonatomic) IBOutlet UISegmentedControl *creature_phylum;
@property (weak, nonatomic) IBOutlet UISegmentedControl *creature_class;

- (IBAction)colorSliderChanged:(UISlider *)sender;
- (IBAction)scaleSliderChanged:(UISlider *)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *scroller;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollerView;

- (IBAction)cropImage:(id)sender;
- (IBAction)backgroundTap:(id)sender;


@end


@protocol PXDetailViewControllerDelegate
-(void)detailViewControllerDidSave:(PXDetailViewController *)controller;
-(void)detailViewControllerDidCancel:(PXDetailViewController *)controller;
@end
