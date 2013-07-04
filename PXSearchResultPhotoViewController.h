//
//  PXSearchResultPhotoViewController.h
//  Phylodex
//
//  Description: Displays the search result photo with accreditation info
//
//  Created by Steve King on 2013-06-23.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//
#import <UIKit/UIKit.h>


@interface PXSearchResultPhotoViewController : UIViewController

@property (retain, nonatomic) UIImage *image;
@property (retain, nonatomic) NSString *nameText;
@property (retain, nonatomic) NSString *creditText;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *creditLabel;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@end
