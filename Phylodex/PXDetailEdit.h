//
//  PXDetailEdit.h
//  Phylodex
//
//  Description: Allows users to edit the details of their phylodex items
//
//  Created by Artha on 13-7-10.
//  Copyright (c) 2013年 Phylosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Phylodex.h"
#import "PXDetailViewController.h"

@class PXDetailViewController;

@interface PXDetailEdit : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *nameOfCreature;
@property (strong, nonatomic) IBOutlet UITextField *habitatType;
@property (strong, nonatomic) IBOutlet UITextField *artistInfo;
@property (strong, nonatomic) IBOutlet UILabel *displayLabel;
@property (strong, nonatomic) PXDetailViewController *parent;
@property (nonatomic, retain) UIBarButtonItem *saveButton;



- (IBAction)backgroundTap:(id)sender;


@end
