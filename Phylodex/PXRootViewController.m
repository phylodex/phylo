//
//  PXRootViewController.m
//  Phylodex
//
//  Description: Main view for the Phylodex user collection of images
//
//  Created by Steve King on 2013-06-18.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXRootViewController.h"

@interface PXRootViewController ()

@end

@implementation PXRootViewController

// id for the custom cell
static NSString *CellTableIdentifier = @"CellTableIdentifier";

@synthesize lifeforms, managedObjectContext, addButton;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = kTitle;
        self.tabBarItem.image = [UIImage imageNamed:@"Phylodex"];
    }
    return self;
}


//----------------------------------
-(void)viewDidAppear:(BOOL)animated{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Phylodex" inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	
	// Order the entries by name
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	
	// Execute the fetch -- create a mutable copy of the result.
	NSError *error = nil;
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	if (mutableFetchResults == nil) {
		// Handle the error.
	}
	[self setLifeforms:mutableFetchResults];    //this sentence can be used to create new card but not to edit
    [self.tableView reloadData];
}
//----------------------------------


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set edit and add buttons in navigation controller
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    //Insertion should come from the capture mode
//    addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPhylo)];
//	addButton.enabled = YES;
//    self.navigationItem.rightBarButtonItem = addButton;
	
    // Fetch existing phylodex entries.
    // Create a fetch request, add a sort descriptor, then execute the fetch.
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Phylodex" inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	
	// Order the entries by name
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	
	// Execute the fetch -- create a mutable copy of the result.
	NSError *error = nil;
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	if (mutableFetchResults == nil) {
		// Handle the error.
	}
	[self setLifeforms:mutableFetchResults];
    
    //get the right table
    UITableView *tableView = (id)[self.view viewWithTag:1];
    //set the height of the cells
    tableView.rowHeight = kTableRowHeight;
    //reference to the custom cell class
    UINib *nib = [UINib nibWithNibName:@"PXNameAndImageCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
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
    // Return the number of rows in the section, determined by the number of photos the user has
    return [lifeforms count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    PXNameAndImageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if (cell == nil) {
        cell = [[PXNameAndImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Get the phylodex entry for the current index path and configure table view cell
    Phylodex *phylo = (Phylodex *)[lifeforms objectAtIndex:indexPath.row];
    cell.name = phylo.name;
    cell.species = phylo.habitat;
    cell.image = phylo.thumbnail;
    
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

// handle deleting of phylodex entries
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		
        // Delete the managed object at the given index path.
		NSManagedObject *eventToDelete = [lifeforms objectAtIndex:indexPath.row];
		[managedObjectContext deleteObject:eventToDelete];
		
		// Update the array and table view.
        [lifeforms removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
		
		// Commit the change.
		NSError *error = nil;
		if (![managedObjectContext save:&error]) {
			// Handle the error.
		}
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
    // set the child controller, and its delegate to the root controller
    PXDetailViewController *detailViewController = [[PXDetailViewController alloc] init];
    detailViewController.delegate = self;

    // Get the phylodex entry for the current index path and set the values for the child controller
    Phylodex *phylo = (Phylodex *)[lifeforms objectAtIndex:indexPath.row];
    
    // NOTE: Need to make properties for each of the fields in the detail view controller, the
    // IBOutlets will populate themselves from these property values
    // Likely just make a property for the Phylodex object for the detail view controller
    
    detailViewController.image = phylo.photo.image;
    
    detailViewController.nameOfCreature.text = phylo.name;
    detailViewController.title = phylo.name;
    detailViewController.phyloELement = phylo;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - PXDetailViewControllerDelegate methods

- (void)detailViewControllerDidSave:(PXDetailViewController *)controller
{
    // TO-DO: save the changes made by user in child controller to the persistent data store and reload data
    [controller.navigationController popViewControllerAnimated:YES];
}

- (void)detailViewControllerDidCancel:(PXDetailViewController *)controller
{
    // TO-DO: reset the values from the model and return to the phylodex
    [controller.navigationController popViewControllerAnimated:YES];
}

#pragma mark - custom event handlers

- (void)addPhylo
{
    // TO-DO: Implement a method to add a new entry
    // this should push the detail view controller or an add view controller
    
// ---------------------------------------------
    //PROBLEM: there is no image added function in edit view
    //SUGGESTION: this should push the camera mode or photo library
//    
    PXDetailViewController *detailViewController = [[PXDetailViewController alloc]init];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
// ---------------------------------------------
    
}

@end
