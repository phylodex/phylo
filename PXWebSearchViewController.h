//
//  PXWebSearchViewController.h
//  Phylodex
//
//  Description: Used to make queries to the web service to find lifeform data and pictures
//
//  Created by Steve King on 2013-06-18.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXSearchResultsViewController.h"
#import "PXNetworkConnection.h"
#import "PXDownloadManager.h"

@interface PXWebSearchViewController : UIViewController <UITextFieldDelegate, PXSearchResultsViewControllerDelegate, PXDownloadManagerDelegate> {
    IBOutlet UITextField *searchTextField;
	IBOutlet UIButton *searchButton;
    IBOutlet UIButton *clearButton;
    IBOutlet UIButton *background;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UILabel *isSearchingLabel;
    PXSearchResultsViewController *childController;
}

@property (nonatomic, retain) UIButton *background;
@property (nonatomic, retain) UITextField *searchTextField;
@property (nonatomic, retain) UIButton *searchButton;
@property (nonatomic, retain) UIButton *clearButton;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) UILabel *isSearchingLabel;

// TO-DO: 
// implement the UITextFieldDelegate methods to improve interaction

- (IBAction)searchButtonWasPressed:(id)sender;
- (IBAction)clearButtonWasPressed:(id)sender;
- (IBAction)backgroundClick:(id)sender;

// PXDownloadManagerDelegate methods
- (void)downloadDidStart;
- (void)updateStatus:(NSString *)statusString;
- (void)downloadDidStopWithStatus:(NSString *)statusString forService:(WebServiceType)service;

@end