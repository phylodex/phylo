//
//  PXDetailViewController.m
//  Phylodex
//
//  Created by Steve King on 2013-06-24.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXDetailViewController.h"
#import "PXCropViewController.h"
#import "ViewController.h"
#import "PXHabitat.h"
#import "PXType.h"

@interface PXDetailViewController ()

@end

@implementation PXDetailViewController

//@synthesize nameTextField;
@synthesize speciesTextField;
@synthesize lifeforms;
@synthesize image;
@synthesize imageView;
@synthesize cropButton;
@synthesize tableView;
@synthesize tableViewContro;
//@synthesize model;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (IBAction)cropButtonWasPressed:(id)sender{
    /*
     //do not try this part to switch views, it will create compling errors
     ViewController *cropImageView = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    //[cropImageView setImageView:imageView];
     [self.view addSubview:cropImageView.view];    */
    NSLog(@"yes");
    PXCropViewController *cropImageView=[[PXCropViewController alloc]init];
    [self presentViewController:cropImageView animated:YES completion:nil];
    /*
     // Yujie did not try this one, just leave it here.
     ImageCropper *cropper = [[ImageCropper alloc] initWithImage:[self.imageView image]];
	//[cropper setDelegate:self];
	
	[self presentViewController:cropper animated:YES completion:nil];*/
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //nameTextField.text = model.name;
    //speciesTextField.text = model.species;
    imageView.image = image;
    [tableView addSubview:tableViewContro.tableView];
    [tableView setContentSize:CGSizeMake(tableView.frame.size.width, 200)];
//    [tableViewContro setdelegate:self];
}
   
    //table view section of detail view
-(NSInteger)numberOfSectionInTableView:(UITableView *)tableView{
        return 1;
    }
    
    //table view rows of detail view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return 4;
    }
    
    //table view contents of detail view
-(UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Maincell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Maicell"];
        }
        PXDummyModel *lifeform = [lifeforms objectAtIndex:indexPath.row];

        if (indexPath.row == 0) {
            cell.textLabel.text = @"Name: %s", lifeform.name;
        }else if (indexPath.row == 1) {
            cell.textLabel.text = @"Type: %s", lifeform.species;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 2) {
            cell.textLabel.text = @"Habitat: ";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 3) {
            cell.textLabel.text = @"Notes: ";
        }
        
        return cell;
}
     
     
     //Crop Image button leads to next page
  /*   - (IBAction)CropButton:(UIButton *)sender {
     if(self.cropViewController.view.superview==nil){
     if(self.cropViewController==nil){
     PXCropViewController *crop = [[PXCropViewController alloc]initWithNibName:@"cropViewController" bundle:nil];
     self.cropViewController = crop;
     
     }
     [firstViewController.view removeFromSuperview];
     [self.view insertSubview:cropViewController.view atIndex:0];
     }
     
     }*/

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     //PXHabitat *resultController = [[PXHabitat alloc]initWithNibName:@"PXHabitat" bundle:nil];
     //    resultController.discription = [resultArray objectAtIndex:indexPath.row];
     //[self.navigationController pushViewController:resultController animated:YES];
    
}
    


- (void)imageCropper:(ImageCropper *)cropper didFinishCroppingWithImage:(UIImage *)image {
	[imageView setImage:image];
	
	[self dismissModalViewControllerAnimated:YES];
	
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)imageCropperDidCancel:(ImageCropper *)cropper {
	[self dismissModalViewControllerAnimated:YES];
	
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
