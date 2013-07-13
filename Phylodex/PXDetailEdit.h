//
//  PXDetailEdit.h
//  Phylodex
//
//  Created by Artha on 13-7-10.
//  Copyright (c) 2013年 Phylosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Phylodex.h"
#import "PXDetailViewController.h"

@interface PXDetailEdit : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *nameOfCreature;
@property (strong, nonatomic) IBOutlet UITextField *habitatType;
@property (strong, nonatomic) IBOutlet UITextField *artistInfo;
@property (strong, nonatomic) IBOutlet NSDate *date;    //weired label
@property (strong, nonatomic) IBOutlet UILabel *displayLabel;
@property (strong, nonatomic) PXDetailViewController *parent;

- (IBAction)save:(id)sender;
- (IBAction)backgroundTap:(id)sender;


@end
