//
//  PXDetailViewController.h
//  Phylodex
//
//  Description: Shows the Detail view for each user photo
//
//  Created by Steve King on 2013-06-20.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PXDetailViewControllerDelegate;


@interface PXDetailViewController : UITableViewController

@property (nonatomic, assign)id <PXDetailViewControllerDelegate>delegate;

-(IBAction)save:(id)sender;	// return to root view saving data
-(IBAction)cancel:(id)sender; // return to root view discarding changes

@end


@protocol PXDetailViewControllerDelegate
-(void)detailViewControllerDidSave:(PXDetailViewController *)controller;
-(void)detailViewControllerDidCancel:(PXDetailViewController *)controller;
@end

