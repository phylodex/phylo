//
//  PXCameraViewController.m
//  Phylodex
//
//  Created by MengTing Yang on 13-07-03.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXCameraViewController.h"

@interface PXCameraViewController ()

@end

@implementation PXCameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        /*
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            
            [self setSourceType:UIImagePickerControllerSourceTypeCamera];
        }
        else
        {
            [self setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
         */
        [self setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self setDelegate:self];
        
        self.title = @"Capture";
        self.tabBarItem.image = [UIImage imageNamed:@"Capture"];

    }
    return self;
}

- (void)viewDidLoad
{
    [self setSourceType:UIImagePickerControllerSourceTypeCamera];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    PXDummyModel *model= [[PXDummyModel alloc]init];
    model.image=image;
    model.name=@"hell";
    model.species=@"hell";
    detailViewController.image = model.image;
    detailViewController.nameTextField.text = model.name;
    detailViewController.speciesTextField.text = model.species;
    NSString *title = @"hell";
    detailViewController.title = title;
    PXAppDelegate *appDelegate = (PXAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.rootController setSelectedIndex:0];
    NSArray *controllers=[appDelegate.rootController viewControllers];
    UINavigationController *rootNav=[controllers objectAtIndex:0];
    [rootNav pushViewController:detailViewController animated:NO];
    PXRootViewController *root=[[rootNav viewControllers]objectAtIndex:0];
    [root.lifeforms addObject:model];
   
    //[self.imageView setImage:image];
    //[self dismissModalViewControllerAnimated:YES];
}

@end
