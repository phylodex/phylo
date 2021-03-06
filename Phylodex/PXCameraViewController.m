//
//  PXCameraViewController.m
//  Phylodex
//
//  Created by MengTing Yang on 13-07-03.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXCameraViewController.h"
#import "PXUserManager.h"
#import "Users.h"

@interface PXCameraViewController ()

@end

@implementation PXCameraViewController
@synthesize libraryButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        //  [self setSourceType:UIImagePickerControllerSourceTypeCamera];
        //        [self setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self setDelegate:self];
        
        self.title = @"Capture";
        self.tabBarItem.image = [UIImage imageNamed:@"Capture"];
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        
        libraryButton.hidden = NO;
    }
    if(self.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
        if(libraryButton!=nil)
            libraryButton.hidden = YES;
    }
    
    
}
- (void)viewDidLoad
{
    // build error or source error, please comment out this
    
    //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        [self setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else
    {
        [self setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    
    //[self setSourceType:UIImagePickerControllerSourceTypeCamera];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    libraryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [libraryButton addTarget:self
                      action:@selector(showLibaray:)
            forControlEvents:UIControlEventTouchDown];
    [libraryButton setTitle:@"Library" forState:UIControlStateNormal];
    libraryButton.frame = CGRectMake(10, 10, 80, 40.0);
    [self.view addSubview:libraryButton];
    
    
}

-(void) showCamera{
    [self setSourceType:UIImagePickerControllerSourceTypeCamera];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    PXDetailViewController *detailViewController = [[PXDetailViewController alloc] init];
    //detailViewController.delegate = self;
    
    // set the title of the detail view to the name of the animal (hard-coded for now)
    
    //XDummyModel *lifeform = [lifeforms objectAtIndex:indexPath.row];
    //detailViewController.model = lifeform;
    PXAppDelegate *appDelegate = (PXAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext=appDelegate.managedObjectContext;
    
    PXDummyModel *model= [[PXDummyModel alloc]init];
    
    model.image=image;
    model.name=@"new";
    model.species=@"new";
    
    Phylodex *phylo = (Phylodex *)[NSEntityDescription insertNewObjectForEntityForName:@"Phylodex" inManagedObjectContext:managedObjectContext];
    Photo *photo = (Photo *)[NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:managedObjectContext];
    
    //    [phylo setDate:[NSDate date]]; // Should be timestamp, but this will be constant for simulator.
    [phylo setName:model.name];
    [phylo setHabitat:@"forest"];
    Users *currentUser = [PXUserManager sharedInstance].currentUser;
    [phylo setUser:currentUser];
    
    // Associate the photo object with the phylodex entry
    photo.image = image;
    
    // Create a thumbnail version of the image for the event object.
    CGSize size = image.size;
    CGFloat ratio = 0;
    if (size.width > size.height) {
        ratio = 65.0 / size.width;
    }
    else {
        ratio = 65.0 / size.height;
    }
    CGRect rect = CGRectMake(0.0, 0.0, ratio * size.width, ratio * size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    phylo.thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [phylo setPhoto:photo];
    
    detailViewController.image = model.image;
    //    detailViewController.nameTextField.text = model.name;

    NSString *title = @"New";
    detailViewController.title = title;
    NSError *error = nil;
	if (![managedObjectContext save:&error]) {
		// Handle the error.
	}
    [appDelegate.rootController setSelectedIndex:0];
    //NSArray *controllers=[appDelegate.rootController viewControllers];
    //UINavigationController *rootNav=[controllers objectAtIndex:0];
    //[rootNav pushViewController:detailViewController animated:NO];
    //PXRootViewController *root=[rootNav.viewControllers objectAtIndex:0];
    //[root.tableView reloadData];
    
    //PXRootViewController *root=[[rootNav viewControllers]objectAtIndex:0];
    //[root.lifeforms addObject:model];
    
    //[self.imageView setImage:image];
    //[self dismissModalViewControllerAnimated:YES];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:NO completion:NULL];
    [self setSourceType:UIImagePickerControllerSourceTypeCamera];
    PXAppDelegate *appDelegate = (PXAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.rootController setSelectedIndex:0];
    
}



- (void)showLibaray:(id)sender {
    [self setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [libraryButton setHidden:YES];
}
@end
