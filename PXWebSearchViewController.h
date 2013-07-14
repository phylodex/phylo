//
//  PXWebSearchViewController.h
//  Phylodex
//
//  Description: Used to make queries to the web service to find lifeform pictures
//
//  Created by Steve King on 2013-06-18.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXSearchResultsViewController.h"
#import "PXNetworkConnection.h"
#import "PXXMLParser.h"

@interface PXWebSearchViewController : UIViewController <UITextFieldDelegate, PXSearchResultsViewControllerDelegate> {
    IBOutlet UITextField *searchTextField;
	IBOutlet UIButton *searchButton;
    IBOutlet UIButton *clearButton;
    IBOutlet UIButton *background;
    PXSearchResultsViewController *childController;
}

@property (nonatomic, retain) UIButton *background;
@property (nonatomic, retain) UITextField *searchTextField;
@property (nonatomic, retain) UIButton *searchButton;
@property (nonatomic, retain) UIButton *clearButton;

// TO-DO: 
// implement the UITextFieldDelegate methods to improve interaction
- (IBAction)searchButtonWasPressed:(id)sender;
- (IBAction)clearButtonWasPressed:(id)sender;
- (IBAction)backgroundClick:(id)sender;

@end
