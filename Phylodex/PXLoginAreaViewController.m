//
//  PXLoginAreaViewController.m
//  Phylodex
//
//  Created by Steve King on 2013-07-25.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXLoginAreaViewController.h"
#import "Users.h"

@interface PXLoginAreaViewController ()
@property (nonatomic, retain)Users *loggedInUser;
@property (nonatomic, retain)UINavigationController *navController;

@end

@implementation PXLoginAreaViewController

@synthesize users, loggedInUser;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"Users";
        self.tabBarItem.image = [UIImage imageNamed:@"Accounts"];
        [self refreshUserDatabase];
    }
    return self;
}

- (void)refreshUserDatabase
{
    // get the array of users from the manager
    users = [[PXUserManager sharedInstance] getUsers];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refreshUserDatabase];
}

- (void)viewWillAppear:(BOOL)animated
{

        
}

- (void)viewDidAppear:(BOOL)animated
{
    [self refreshUserDatabase];
    [self.tableView reloadData];
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    // get the selected user
    Users *currentUser = [users objectAtIndex:indexPath.row];
    
    // get the child controller login screen and push it onto navigation stack
    PXLoginScreenViewController *loginScreenController = [[PXLoginScreenViewController alloc] init];
    loginScreenController.title = currentUser.userName;
    loginScreenController.userID = currentUser.userID;
    loginScreenController.delegate = self;
    [self.navigationController pushViewController:loginScreenController animated:YES];
}

#pragma mark - PXLoginScreenViewControllerDelegate methods

-(void)loginDidCancel
{

    [self.navigationController popToRootViewControllerAnimated:YES];
}

// called when the user successfully logs in, and the login screen disappears
- (void) userDidLogin
{

}

#pragma mark - PXUserSpaceViewControllerDelegate methods

- (void) userDidLogout:(PXUserSpaceViewController *)sender
{
    
}

@end
