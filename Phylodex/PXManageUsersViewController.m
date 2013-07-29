//
//  PXManageUsersViewController.m
//  Phylodex
//
//  Created by Steve King on 2013-07-27.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXManageUsersViewController.h"
#import "PXAppDelegate.h"

@interface PXManageUsersViewController ()

@end

@implementation PXManageUsersViewController

@synthesize users, delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"Manage Users";
        [self refreshUserDatabase];
    }
    return self;
}

- (void)refreshUserDatabase
{
    // get the array of users from the manager
    NSArray *usersArray = [[PXUserManager sharedInstance] getUsers];
    users = [[NSMutableArray alloc] initWithCapacity:[usersArray count]];
    [users addObjectsFromArray:usersArray];
//    users = [[PXUserManager sharedInstance] getUsers];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // create the button to add list item
	UIBarButtonItem *plusButton = [[UIBarButtonItem alloc]
								   initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
								   target:self
								   action:@selector(addListItem)];
    // add the plus UIBarButtonItem to the top bar on the right
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:self.editButtonItem, plusButton, nil];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Log Out"
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(logout:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)logout:(id)sender
{
    [delegate userDidLogout:self];
}

// called when the user touches the plus button
- (void)addListItem {
	// create new AddViewController
	PXNewUserViewController *newUserController = [[PXNewUserViewController alloc] initWithNibName:@"PXNewUserViewController" bundle:nil];
	newUserController.delegate = self; // set controller’s delegate to self
	
	newUserController.title = @"New User";
	// show the new controller
	[self.navigationController pushViewController:newUserController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	}
    
    // Configure the cell...
    Users *currentUser = [users objectAtIndex:indexPath.row];
    cell.textLabel.text = currentUser.userName;
    cell.detailTextLabel.text = currentUser.role;
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        // Update the array and table view.
        NSUInteger row = indexPath.row;
        Users *userToRemove = [users objectAtIndex:row];
        [users removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source
        [[PXUserManager sharedInstance] removeUser:userToRemove];
//        [tableView reloadData];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Users *currentUser = [users objectAtIndex:indexPath.row];
    
    // get the child controller login screen and push it onto navigation stack
    PXEditUserViewController *editScreenController = [[PXEditUserViewController alloc] initWithNibName:@"PXEditUserViewController" bundle:nil];
    editScreenController.user = currentUser;
    [self.navigationController pushViewController:editScreenController animated:YES];
}

#pragma mark - PXNewUserViewControllerDelegate

- (void)cancel:(UIViewController *)controller
{
    [controller.navigationController popViewControllerAnimated:YES];
}

- (void)newUserWasCreated:(UIViewController *)controller
{
    PXNewUserViewController *child = (PXNewUserViewController *)controller;
    
    // add the user to the database
    NSString *newUserName = child.userNameTextField.text;
    NSString *newUserPassword = child.passwordTextField.text;
    NSString *newFullName = child.fullNameTextField.text;
    
    [[PXUserManager sharedInstance] addUserWithUserName:newUserName andPassword:newUserPassword andFullName:newFullName];
    
    [controller.navigationController popViewControllerAnimated:YES];
    
    // update the manage user table
    [self refreshUserDatabase];
    [self.tableView reloadData];
}

@end