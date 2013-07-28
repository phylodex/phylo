//
//  PXLoginAreaViewController.h
//  Phylodex
//
//  Created by Steve King on 2013-07-25.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXUserManager.h"
#import "PXLoginScreenViewController.h"
#import "PXUserSpaceViewController.h"

@interface PXLoginAreaViewController : UITableViewController <PXLoginScreenViewControllerDelegate>

// array of users
@property (nonatomic, retain)NSArray *users;

//@property (nonatomic, retain)PXUserSpaceViewController *userSpaceController;
//@property (nonatomic, retain)PXLoginScreenViewController *loginScreenController;

@end
