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
#import "simpleTableCell.h"
//#import "Photo.h"

@class PXDetailViewController;
@class Phylodex;
@class Photo;

@protocol PXDetailViewControllerDelegate;

@interface PXDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource, ImageCropperDelegate>{
    PXDetailViewController *detailView;
    UIImageView *imageView;
    Phylodex *phyloElement;
    
}


@property (nonatomic, retain) NSMutableArray *valueArray;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) Phylodex *phyloELement;
@property (nonatomic, retain) Photo *photo;

@property (nonatomic, assign)id <PXDetailViewControllerDelegate>delegate;
@property (retain, nonatomic) IBOutlet UIImage *image;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) UITableView *table;
@property (strong, nonatomic) IBOutlet UIScrollView *tableView;
@property (strong, nonatomic) IBOutlet UITableViewController *tableViewContro;
@property (nonatomic, retain) IBOutlet UIWindow *window;

- (IBAction)editButton:(id)sender;

@end


@protocol PXDetailViewControllerDelegate
-(void)detailViewControllerDidSave:(PXDetailViewController *)controller;
-(void)detailViewControllerDidCancel:(PXDetailViewController *)controller;
@end
