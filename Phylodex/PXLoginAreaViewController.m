//
//  PXLoginAreaViewController.m
//  Phylodex
//
//  Created by Steve King on 2013-07-25.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXLoginAreaViewController.h"

@interface PXLoginAreaViewController ()
@property (nonatomic, retain)PXDummyUser *loggedInUser;
@property (nonatomic, retain)UINavigationController *navController;
//@property (nonatomic, retain)NSMutableArray *navigationControllers;
//@property (nonatomic, assign)BOOL shouldRefreshDisplay;

//// enum to define what web service is currently being queried
//typedef NS_ENUM(NSInteger, NavigationControllerType) {
//    RootView = 0,
//    LoginScreenView = 1,
//    UserSpaceView = 2
//};
//#define kNumberOfViewControllers 4

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
    PXDummyUser *currentUser = [users objectAtIndex:indexPath.row];
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
    PXDummyUser *currentUser = [users objectAtIndex:indexPath.row];
    
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
//    [self.navigationController popToRootViewControllerAnimated:NO];
//    if (loggedInUser != nil) {
//        if (navController == self.navigationController) {
//    PXUserSpaceViewController *userSpaceController = [navigationControllers objectAtIndex:UserSpaceView];
//    userSpaceController.delegate = self;
//    [self.navigationController pushViewController:userSpaceController animated:YES];
//        }
//    }
}

#pragma mark - PXUserSpaceViewControllerDelegate methods

- (void) userDidLogout:(PXUserSpaceViewController *)sender
{
    
    
//    [[self.navigationControllers objectAtIndex:2] popViewControllerAnimated:NO];
//    [[navigationControllers objectAtIndex:1] popViewControllerAnimated:NO];
    
    
//    NSArray *conts = self.navigationControllers;
//    
////    [sender.navigationController popViewControllerAnimated:NO];
////    [sender.navigationController popToViewController:[self.navigationControllers objectAtIndex:0] animated:YES];
////    assert(navController == self.navigationController);
////    [userSpaceController.navigationController popViewControllerAnimated:YES];
////    userSpaceController = nil;
//    
//    /* Get the current array of View Controllers */
//    NSArray *currentControllers = self.navigationControllers;
//    
//    /* Create a mutable array out of this array */
//    NSMutableArray *newControllers = [NSMutableArray arrayWithObject:[currentControllers objectAtIndex:0]];
   
//    [sender.navigationController popToRootViewControllerAnimated:YES];
//    
//    /* Get the current array of View Controllers */
//    NSArray *currentControllers = self.navigationControllers;
//    
//    /* Create a mutable array out of this array */
//    NSMutableArray *newControllers = [NSMutableArray arrayWithObject:[currentControllers objectAtIndex:0]];
//    
//    /* Assign this array to the Navigation Controller */
//    self.navigationControllers = newControllers;

    
    
    /* Assign this array to the Navigation Controller */
//    self.navigationControllers = newControllers;
}

@end
