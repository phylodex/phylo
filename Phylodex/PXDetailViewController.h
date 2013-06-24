//
//  PXDetailViewController.h
//  Phylodex
//
//  Created by Steve King on 2013-06-24.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXDummyModel.h"

@protocol PXDetailViewControllerDelegate;

@interface PXDetailViewController : UIViewController

@property (nonatomic, assign)id <PXDetailViewControllerDelegate>delegate;
//@property (retain, nonatomic) PXDummyModel *model;
@property (retain, nonatomic) IBOutlet UIImage *image;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *cropButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *speciesTextField;

@end


@protocol PXDetailViewControllerDelegate
-(void)detailViewControllerDidSave:(PXDetailViewController *)controller;
-(void)detailViewControllerDidCancel:(PXDetailViewController *)controller;
@end
