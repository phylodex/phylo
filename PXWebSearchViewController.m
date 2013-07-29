//
//  PXWebSearchViewController.m
//  Phylodex
//
//  Created by Steve King on 2013-06-18.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXWebSearchViewController.h"
#import "PXXMLParserFirstStep.h"

@interface PXWebSearchViewController ()
@property (nonatomic, retain) PXDownloadManager *downloadManager;
@end

@implementation PXWebSearchViewController

@synthesize background;
@synthesize searchButton;
@synthesize searchTextField;
@synthesize clearButton;
@synthesize downloadManager;
@synthesize isSearchingLabel;
@synthesize activityIndicator;

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
    activityIndicator.hidden = YES;
    isSearchingLabel.hidden = YES;
    
    searchTextField.delegate = self;
    searchTextField.returnKeyType = UIReturnKeyDone;
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - IBAction methods

- (IBAction)searchButtonWasPressed:(id)sender
{
    // check to make sure the field isn't empty
    if ([searchTextField.text length] != 0)
    {
        downloadManager = [[PXDownloadManager alloc] initWithTypeOfService:GlobalSpeciesListByName];
        downloadManager.delegate = self;
        [downloadManager queryWebServiceForData:searchTextField.text];
    }
}

- (IBAction)clearButtonWasPressed:(id)sender;
{
    // clears the text field
    searchTextField.text = nil;
    [searchTextField resignFirstResponder];
    [downloadManager terminateConnection];
}

-(IBAction)backgroundClick:(id)sender {
	[searchTextField resignFirstResponder];
}

# pragma mark - PXSearchResultsViewControllerDelegate methods

- (void)searchViewControllerDidEnd:(PXSearchResultsViewController *)controller
{
    // TO DO
    // keep a record of the previous search in case that same search is made again
    
}

#pragma mark - web search view delegate methods for updating the UI

- (void)downloadDidStart
{
    [searchTextField resignFirstResponder];
    activityIndicator.hidden = NO;
    isSearchingLabel.hidden = NO;
    [activityIndicator startAnimating];
}

- (void)updateStatus:(NSString *)statusString
{
    return;
}

- (void)downloadDidStopWithStatus:(NSString *)statusString forService:(WebServiceType)service
{
    [activityIndicator stopAnimating];
    activityIndicator.hidden = YES;
    isSearchingLabel.hidden = YES;
    
    // if the status is nil, it means the download was OK
    if (statusString == nil) {
        NSString *XMLDataString = [[NSString alloc] initWithContentsOfFile:downloadManager.filePath encoding:NSUTF8StringEncoding error:nil];
//        NSLog(@"xml data: %@", XMLDataString);
        
        // parse the XML data into a mutable array
        PXXMLParserFirstStep *parser = [[PXXMLParserFirstStep alloc] init];
        NSMutableArray *results = [parser parseNameArray:XMLDataString];
        
        // push the child view controller of search results
        childController = [[PXSearchResultsViewController alloc] init];
        childController.searchResults = results;
        childController.title = searchTextField.text;
        [self.navigationController pushViewController:childController animated:YES];
    }
}

- (void)downloadWasTerminated
{
    [activityIndicator stopAnimating];
    activityIndicator.hidden = YES;
    isSearchingLabel.hidden = YES;
}

@end
