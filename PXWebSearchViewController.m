//
//  PXWebSearchViewController.m
//  Phylodex
//
//  Created by Steve King on 2013-06-18.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXWebSearchViewController.h"

@interface PXWebSearchViewController ()

@end

@implementation PXWebSearchViewController

@synthesize background;
@synthesize searchButton;
@synthesize searchTextField;
@synthesize clearButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Search";
        self.tabBarItem.image = [UIImage imageNamed:@"Search"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate methods

// became first responder
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // user now editing text field
}

// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    // ending editing text field
}

// called when clear button pressed. return NO to ignore (no notifications)
//- (BOOL)textFieldShouldClear:(UITextField *)textField {}

// called when 'return' key pressed. return NO to ignore.
//- (BOOL)textFieldShouldReturn:(UITextField *)textField {}

#pragma mark - IBAction methods

- (IBAction)searchButtonWasPressed:(id)sender
{
    // check to make sure the field isn't empty
    if ([searchTextField.text length] != 0)
    {
        // TO-DO: create a new network search
        
        // make sure we can connect to the internet
        PXNetworkConnection *connection = [[PXNetworkConnection alloc] init];
        
        // make the search result, and extract the data
        // note: will eventually implement as a block so that the user receives feedback that the search is under way
        NSString *searchResultXMLData = [connection queryWebServiceForData:searchTextField.text];
        NSMutableArray *searchResultItems = [PXXMLParser extractItemsFromXMLData:searchResultXMLData];
        
        // push the search results child view passing the network search result
        PXSearchResultsViewController *resultsViewController = [[PXSearchResultsViewController alloc] init];
        resultsViewController.delegate = self;
        resultsViewController.searchResults = searchResultItems;
        
        // set the title of the search view to the search string
        NSString *query = searchTextField.text;
        resultsViewController.title = query;
        [self.navigationController pushViewController:resultsViewController animated:YES];
    }
}

- (IBAction)clearButtonWasPressed:(id)sender;
{
    // clears the text field
    searchTextField.text = nil;
    [searchTextField resignFirstResponder];
}

-(IBAction)backgroundClick:(id)sender {
	[searchTextField resignFirstResponder];
}

# pragma mark - PXSearchResultsViewControllerDelegate methods

- (void)searchViewControllerDidEnd:(PXSearchResultsViewController *)controller
{
    // keep a record of the previous search in case that same search is made again
    
}

@end
