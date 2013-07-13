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
#import "PXDetailEdit.h"

@interface PXDetailViewController ()

@end


@implementation PXDetailViewController{
    NSArray *attributeArray;
    NSMutableArray *valueArray;
    
}

//@synthesize lifeforms;
//@synthesize model;

@synthesize name, valueArray, phyloELement;

@synthesize nameTextField;
@synthesize cropButton;
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

    attributeArray= [NSArray arrayWithObjects:@"Name: ", @"Type: ", @"Habitat: ", @"Notes: ", nil];
    valueArray = [[NSMutableArray alloc]initWithObjects:[phyloELement name], @"",[phyloELement habitat],@"", nil];

    imageView = [[UIImageView alloc]initWithImage:image];
    
    [tableView addSubview:tableViewContro.tableView];
    [tableView setContentSize:CGSizeMake(tableView.frame.size.width, 200)];
    
    
    imageView = [[UIImageView alloc] initWithImage:self.image];
	[imageView setFrame:CGRectMake(0.0, -20.0, 320.0, 200.0)];
	[imageView setContentMode:UIViewContentModeScaleAspectFit];
	
	[[self view] addSubview:imageView];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button addTarget:self action:@selector(cropImage) forControlEvents:UIControlEventTouchUpInside];
	[button setFrame:CGRectMake(30.0, 200.0, 130.0, 37.0)];
	[button setTitle:@"Crop Image" forState:UIControlStateNormal];
    
    [[self view] addSubview:button];
    
}


- (void)cropImage {
	ImageCropper *cropper = [[ImageCropper alloc] initWithImage:[imageView image]];
	[cropper setDelegate:self];
	
	[self presentViewController:cropper animated:YES completion:nil];
	
}

- (void)imageCropper:(ImageCropper *)cropper didFinishCroppingWithImage:(UIImage *)image {
	[imageView setImage:imageView.image];
	
	[self dismissViewControllerAnimated:YES completion:nil];
	
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)imageCropperDidCancel:(ImageCropper *)cropper {
	[self dismissViewControllerAnimated:YES completion:nil];
	
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}




//customize cell works. 
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
    cell.valueLabel.text = [valueArray objectAtIndex:indexPath.row];
    
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

- (IBAction)editButton:(id)sender {
    PXDetailEdit *detailEdit = [[PXDetailEdit alloc] init];
    detailEdit.parent = self;
    [self.navigationController pushViewController:detailEdit animated:YES];

}
@end
