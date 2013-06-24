//
//  PXRootViewController.m
//  Phylodex
//
//  Description: Main view for the Phylodex user collection of images
//
//  Created by Steve King on 2013-06-18.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//
// Change_test

#import "PXRootViewController.h"

@interface PXRootViewController ()

@end

@implementation PXRootViewController
//id for the custom cell
static NSString *CellTableIdentifier = @"CellTableIdentifier";

@synthesize lifeforms;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Phylodex";
        self.tabBarItem.image = [UIImage imageNamed:@"Phylodex"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // display edit button
    // TO-DO implement handling of edit functions
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    // populate the collection of lifeforms (user photos)
    lifeforms = [NSMutableArray array];
    PXDummyCollection *collection = [[PXDummyCollection alloc] init];
    for (PXDummyModel *model in collection.dummyModels) {
        [lifeforms addObject:model];
    }
    
    //get the right table
    UITableView *tableView = (id)[self.view viewWithTag:1];
    //set the height of the cells
    tableView.rowHeight = 65;
    //reference to the custom cell class
    UINib *nib = [UINib nibWithNibName:@"PXNameAndImageCell" bundle:nil];
    [tableView registerNib:nib
    forCellReuseIdentifier:CellTableIdentifier];
    
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
    // Return the number of rows in the section.
    // this is determined by the number of photos the user has
    return [lifeforms count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    PXNameAndImageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if (cell == nil) {
        cell = [[PXNameAndImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    PXDummyModel *lifeform = [lifeforms objectAtIndex:indexPath.row];
    cell.name = lifeform.name;
	cell.species = lifeform.species;
    cell.image = lifeform.image;  
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
    
    // set the child controller, and its delegate to the root controller
    PXDetailViewController *detailViewController = [[PXDetailViewController alloc] init];
    detailViewController.delegate = self;

    // set the title of the detail view to the name of the animal (hard-coded for now)
    
    PXDummyModel *lifeform = [lifeforms objectAtIndex:indexPath.row];
    //detailViewController.model = lifeform;
    detailViewController.image = lifeform.image;
    detailViewController.nameTextField.text = lifeform.name;
    detailViewController.speciesTextField.text = lifeform.species;
    NSString *title = lifeform.name;
    detailViewController.title = title;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - PXDetailViewControllerDelegate methods

- (void)detailViewControllerDidSave:(PXDetailViewController *)controller
{
    // save the changes made by user in child controller to the persistent data store and reload data
    [controller.navigationController popViewControllerAnimated:YES];
}

- (void)detailViewControllerDidCancel:(PXDetailViewController *)controller
{
    // do nothing, just return to the phylodex
    [controller.navigationController popViewControllerAnimated:YES];
}

@end
