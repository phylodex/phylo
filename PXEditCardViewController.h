//
//  PXEditCardViewController.h
//  Phylodex
//
//  Created by ParkaPal on 2013-07-25.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXPhyloCardViewController.h"
#import "Phylodex.h"
#import "Photo.h"

@class PXPhyloCardViewController;

@interface PXEditCardViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scroller;

@property (nonatomic, retain) Phylodex *phyloElement;

@property (weak, nonatomic) IBOutlet UITextField *creature_name;
@property (weak, nonatomic) IBOutlet UITextField *creature_sciname;
@property (weak, nonatomic) IBOutlet UITextField *creature_photog;

@property (weak, nonatomic) IBOutlet UISegmentedControl *creature_size;
@property (weak, nonatomic) IBOutlet UISegmentedControl *creature_diet;


@property (weak, nonatomic) IBOutlet UISwitch *creature_hot;
@property (weak, nonatomic) IBOutlet UISwitch *creature_warm;
@property (weak, nonatomic) IBOutlet UISwitch *creature_cool;
@property (weak, nonatomic) IBOutlet UISwitch *creature_cold;

@property (weak, nonatomic) IBOutlet UISegmentedControl *creature_kingdom;
@property (weak, nonatomic) IBOutlet UISegmentedControl *creature_phylum;
@property (weak, nonatomic) IBOutlet UISegmentedControl *creature_class;

@property (weak, nonatomic) IBOutlet UISegmentedControl *hab1;
@property (weak, nonatomic) IBOutlet UISegmentedControl *hab2;
@property (weak, nonatomic) IBOutlet UISegmentedControl *hab3;

@property (strong, nonatomic) PXPhyloCardViewController *parent;

@property(strong, nonatomic) UITextField * activeField;


- (IBAction)save_button_clicked:(id)sender;
- (IBAction)backgroundClick:(id)sender;

@end
