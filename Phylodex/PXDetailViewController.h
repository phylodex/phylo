//
//  PXDetailViewController.h
//  Phylodex
//
//  Created by Steve King on 2013-06-24.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXDummyModel.h"
#import "ImageCropper.h"

@class PXDetailViewController;

@protocol PXDetailViewControllerDelegate;

@interface PXDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource , ImageCropperDelegate>{
    PXDetailViewController *detailView;
    NSMutableArray *resultArray;
    UITableViewController *table;
    //IBOutlet UIImageView *imageView;
}

@property (nonatomic, assign)id <PXDetailViewControllerDelegate>delegate;
//@property (retain, nonatomic) PXDummyModel *model;
@property (retain, nonatomic) IBOutlet UIImage *image;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *cropButton;
//@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *speciesTextField;


@property (retain, nonatomic) NSMutableArray *resultArray;
@property (retain, nonatomic) UITableView *table;
@property (strong, nonatomic) IBOutlet UIScrollView *tableView;
//@property (strong, nonatomic) IBOutlet UIImageView *tableView;
@property (strong, nonatomic) IBOutlet UITableViewController *tableViewContro;
@property (nonatomic, retain)NSMutableArray *lifeforms; //list of animals


- (IBAction)cropButtonWasPressed:(id)sender;

@end


@protocol PXDetailViewControllerDelegate
-(void)detailViewControllerDidSave:(PXDetailViewController *)controller;
-(void)detailViewControllerDidCancel:(PXDetailViewController *)controller;
@end
