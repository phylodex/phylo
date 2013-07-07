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
#import "PXHabitat.h"
#import "PXType.h"
//#import "PXDummyCollection.h"
//#import "PXCropViewController.h"
//#import "ViewController.h"

@class PXDetailViewController;

@protocol PXDetailViewControllerDelegate;

@interface PXDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource, ImageCropperDelegate>{
    PXDetailViewController *detailView;
    UIImageView *imageView;
    
    //    NSMutableArray *resultArray;
    //    UITableViewController *table;
    //IBOutlet UIImageView *imageView;
}

//@property (retain, nonatomic) PXDummyModel *model;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
//@property (retain, nonatomic) NSMutableArray *resultArray;
//@property (copy, nonatomic) NSArray *attributes;
//@property (strong, nonatomic) IBOutlet UIImageView *tableView;
//@property (nonatomic, retain) IBOutlet ViewController *viewController;
//@property (nonatomic, retain)NSMutableArray *lifeforms; //list of animals
@property (weak, nonatomic) IBOutlet UIButton *cropButton;
@property (weak, nonatomic) IBOutlet UITextField *speciesTextField;
@property (nonatomic, assign)id <PXDetailViewControllerDelegate>delegate;
@property (retain, nonatomic) IBOutlet UIImage *image;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) UITableView *table;
@property (strong, nonatomic) IBOutlet UIScrollView *tableView;
@property (strong, nonatomic) IBOutlet UITableViewController *tableViewContro;
@property (nonatomic, retain) IBOutlet UIWindow *window;


- (IBAction)cropButtonWasPressed:(id)sender;

@end


@protocol PXDetailViewControllerDelegate
-(void)detailViewControllerDidSave:(PXDetailViewController *)controller;
-(void)detailViewControllerDidCancel:(PXDetailViewController *)controller;
@end
