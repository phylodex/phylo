//
//  PXRootViewController.h
//  Phylodex
//
//  Description: Main list of the users photos
//
//  Note:   Much of the code on using Core Data was modified from the PhotoLocations app example
//          from the Apple Documentation.
//
//  Created by Steve King on 2013-06-18.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXDetailViewController.h"
//#import "PXDummyCollection.h"
#import "PXNameAndImageCell.h"
#import "Phylodex.h"
#import "Photo.h"

#define kTableRowHeight 65
#define kTitle @"Phylodex"

@interface PXRootViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, PXDetailViewControllerDelegate>
{
    PXDetailViewController *childController;
}

@property (nonatomic, retain)NSMutableArray *lifeforms; // list of plants and animals
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) UIBarButtonItem *addButton;

- (void)addPhylo;

@end
