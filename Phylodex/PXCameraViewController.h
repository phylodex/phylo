//
//  PXCameraViewController.h
//  Phylodex
//
//  Description: Handles the taking of pictures and saving them to the user database
//
//  Created by MengTing Yang on 13-07-03.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXDetailViewController.h"
#import "PXAppDelegate.h"
#import "PXDummyModel.h"

@interface PXCameraViewController : UIImagePickerController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (strong, nonatomic) UIButton *libraryButton;

@end
