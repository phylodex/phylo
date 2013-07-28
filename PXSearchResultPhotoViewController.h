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
#import "PXDownloadManager.h"
#import "PXNameAndContentCell.h"

@interface PXSearchResultPhotoViewController : UIViewController <PXDownloadManagerDelegate,UITableViewDataSource, UITableViewDelegate, UIScrollViewAccessibilityDelegate, UIScrollViewDelegate>

@property (retain, nonatomic) UIImage *image;
//@property (retain, nonatomic) NSString *nameText;
//@property (retain, nonatomic) NSString *creditText;
//@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *creditLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) NSMutableDictionary *resultDictionary;
@property (nonatomic, retain) NSString *uuid;
@property (nonatomic, retain)NSMutableDictionary *speciesData;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (retain, nonatomic) IBOutlet UIScrollView *scroller;

@end
