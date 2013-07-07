//
//  PXDetailViewController.m
//  Phylodex
//
//  Created by Steve King on 2013-06-24.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//
//
//  ImageCropper.h
//  Created by http://github.com/iosdeveloper
//

//#import "SSPhotoCropperDemoViewController.h"
//#import "PXCropViewController.h"

#import "PXDetailViewController.h"
#import "ImageCropper.h"
#import "PXHabitat.h"
#import "PXType.h"

@interface PXDetailViewController ()

@end


@implementation PXDetailViewController{
    NSArray *attributeArray;
    
}

@synthesize nameTextField;
//@synthesize lifeforms;
@synthesize cropButton;
//@synthesize model;
@synthesize speciesTextField;
@synthesize image;
@synthesize imageView;
@synthesize tableView;
@synthesize tableViewContro;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //nameTextField.text = model.name;
    //speciesTextField.text = model.species;
    attributeArray= [NSArray arrayWithObjects:@"Name: ", @"Type: ", @"Habitat: ", @"Notes: ", nil];
    //imageView.image = image;
    [tableView addSubview:tableViewContro.tableView];
    [tableView setContentSize:CGSizeMake(tableView.frame.size.width, 200)];
    //    [tableViewContro setdelegate:self];
    
    
    imageView = [[UIImageView alloc] initWithImage:self.image];
	[imageView setFrame:CGRectMake(0.0, -20.0, 320.0, 200.0)];
	[imageView setContentMode:UIViewContentModeScaleAspectFit];
	
	[[self view] addSubview:imageView];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button addTarget:self action:@selector(cropImage) forControlEvents:UIControlEventTouchUpInside];
	[button setFrame:CGRectMake(30.0, 200.0, 130.0, 37.0)];
	[button setTitle:@"Crop Image" forState:UIControlStateNormal];
    
    [[self view] addSubview:button];
    
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[editButton addTarget:self action:@selector(cropImage) forControlEvents:UIControlEventTouchUpInside];
	[editButton setFrame:CGRectMake(170.0, 200.0, 120.0, 37.0)];
	[editButton setTitle:@"Edit" forState:UIControlStateNormal];
	
    [[self view] addSubview:editButton];
    
}


- (void)cropImage {
	ImageCropper *cropper = [[ImageCropper alloc] initWithImage:[imageView image]];
	[cropper setDelegate:self];
	
	[self presentViewController:cropper animated:YES completion:nil];
	
}

- (void)imageCropper:(ImageCropper *)cropper didFinishCroppingWithImage:(UIImage *)image {
	[imageView setImage:image];
	
	[self dismissViewControllerAnimated:YES completion:nil];
	
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)imageCropperDidCancel:(ImageCropper *)cropper {
	[self dismissViewControllerAnimated:YES completion:nil];
	
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}




//customize cell works. Yujie, do not change anything inside, Please!!!!!
- (UITableViewCell *)tableView:(UITableView *)firstTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"firstTableView is working");
    static NSString *simpleTableIdentifier = @"DetailTableCell";
    
    SimpleTableCell *cell = [firstTableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        //cell = [[SimpleTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PXDetailTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.attributeLabel.text = [attributeArray objectAtIndex:indexPath.row];
    cell.valueLabel.text = @"Yes";
    
    return cell;
}

//table view section of detail view
-(NSInteger)numberOfSectionInTableView:(UITableView *)tableView{
    return 1;
}

//table view rows of detail view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [attributeArray count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 PXHabitat *habitatView = self;
 [self.navigationController pushViewController:habitatView animated:YES];
 }*/

//table view contents of detail view
/*-(UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Maincell"];
 
 if (cell == nil) {
 cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Maicell"];
 }
 cell.textLabel.text = self.attributes[indexPath.row];
 
 return cell;
 }*/


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

/*-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 //PXHabitat *resultController = [[PXHabitat alloc]initWithNibName:@"PXHabitat" bundle:nil];
 //    resultController.discription = [resultArray objectAtIndex:indexPath.row];
 //[self.navigationController pushViewController:resultController animated:YES];
 
 }*/



/*- (void)imageCropper:(ImageCropper *)cropper didFinishCroppingWithImage:(UIImage *)image {
 [imageView setImage:image];
 
 [self dismissViewControllerAnimated:YES completion:nil];
 
 [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
 }*/

/*- (void)imageCropperDidCancel:(ImageCropper *)cropper {
 [self dismissViewControllerAnimated:YES completion:nil];
 
 [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
 }
 */


/*- (IBAction)cropButtonWasPressed:(id)sender{
 
 //do not try this part to switch views, it will create compling errors
 ViewController *cropImageView = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
 //[cropImageView setImageView:imageView];
 [self.view addSubview:cropImageView.view];
 */

/*
 //this works
 NSLog(@"Now crop image button works");
 ViewController *cropImageView=[[ViewController alloc]init];
 [self presentViewController:cropImageView animated:YES completion:nil];
 */

/*NSLog(@"yes");
 SSPhotoCropperDemoViewController *cropImageView=[[SSPhotoCropperDemoViewController alloc]init];
 [self presentViewController:cropImageView animated:YES completion:nil];
 */

/*
 // Yujie did not try this one, just leave it here.
 ImageCropper *cropper = [[ImageCropper alloc] initWithImage:[self.imageView image]];
 //[cropper setDelegate:self];
 
 [self presentViewController:cropper animated:YES completion:nil];
 }*/


@end
