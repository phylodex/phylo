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
#import "IZValueSelectorView.h"

@class PXDetailViewController;
@class Phylodex;
@class Photo;

@protocol PXDetailViewControllerDelegate;

@interface PXDetailViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate,ImageCropperDelegate, IZValueSelectorViewDataSource,IZValueSelectorViewDelegate>{
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
@property (strong, nonatomic) IBOutlet UITextField *terrain;
@property (strong, nonatomic) IBOutlet UITextField *evolutionary;
@property (strong, nonatomic) IBOutlet UITextView *desc;


@property (strong, nonatomic) IBOutlet UILabel *displayLabel;
@property (strong, nonatomic) IBOutlet UILabel *pointValue;
@property (strong, nonatomic) IBOutlet UILabel *foodChain;
@property (strong, nonatomic) IBOutlet UILabel *scaleNumber;
@property (strong, nonatomic) IBOutlet UIImageView *pointColor;

- (IBAction)toggleControls:(UISegmentedControl *)sender;
- (IBAction)toggleControls2:(UISegmentedControl *)sender;
- (IBAction)toggleControls3:(UISegmentedControl *)sender;
//- (IBAction)numberSliderChanged:(UISlider *)sender;
- (IBAction)colorSliderChanged:(UISlider *)sender;
- (IBAction)scaleSliderChanged:(UISlider *)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *scroller;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollerView;

- (IBAction)cropImage:(id)sender;
- (IBAction)backgroundTap:(id)sender;

// Picker Library Part
@property (weak, nonatomic) IBOutlet IZValueSelectorView *selectorVertical1;
@property (weak, nonatomic) IBOutlet IZValueSelectorView *selectorVertical2;
@property (weak, nonatomic) IBOutlet IZValueSelectorView *selectorVertical3;
////////////////////////


@end


@protocol PXDetailViewControllerDelegate
-(void)detailViewControllerDidSave:(PXDetailViewController *)controller;
-(void)detailViewControllerDidCancel:(PXDetailViewController *)controller;
@end
