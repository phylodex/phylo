//
//  PXRootViewController.h
//  Phylodex
//
//  Description: Main list of the users photos
//
//  Created by Steve King on 2013-06-18.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXDetailViewController.h"
#import "PXDummyCollection.h"
#import "PXNameAndImageCell.h"

@interface PXRootViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, PXDetailViewControllerDelegate> {
    PXDetailViewController *childController;
}

@property (nonatomic, retain)NSMutableArray *lifeforms; // list of animals

@end
