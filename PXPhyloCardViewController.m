//
//  PXPhyloCardViewController.m
//  Phylodex
//
//  Created by ParkaPal on 2013-07-25.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXPhyloCardViewController.h"
#import "PXAppDelegate.h"

@interface PXPhyloCardViewController ()

@end

@implementation PXPhyloCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //add the send button to the nav bar
        UIBarButtonItem *btnEdit = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Edit"
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(edit_button_clicked:)];
        self.navigationItem.rightBarButtonItem = btnEdit;
        
        //set some UI visuals

    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _name_label.text = _phyloElement.name;
    
    _sciname_label.text = _phyloElement.scientific_name;
    _phyloCardImage.image = _image;
    
    NSMutableString *sizeIMGpath = [[NSMutableString alloc]init];
    [sizeIMGpath appendString:_phyloElement.creature_size];
    [sizeIMGpath appendString:@".png"];
    _size_img.image = [UIImage imageNamed:sizeIMGpath];

    
    NSMutableString *dietIMGpath = [[NSMutableString alloc]init];
    [dietIMGpath appendString:_phyloElement.diet];
    [dietIMGpath appendString:_phyloElement.heirarchy];
    [dietIMGpath appendString:@".png"];
    _diet_img.image = [UIImage imageNamed:dietIMGpath];
    
    _points_label.text = [NSString stringWithFormat:@"%@ Points", _phyloElement.points];
    
    NSMutableString *climateList = [[NSMutableString alloc]init];
    if ([_phyloElement.cold isEqualToNumber:[NSNumber numberWithInt:1]]){
        [climateList appendString:@"Cold, "];
    }
    if ([_phyloElement.cool isEqualToNumber:[NSNumber numberWithInt:1]]){
        [climateList appendString:@"Cool, "];
    }
    if ([_phyloElement.warm isEqualToNumber:[NSNumber numberWithInt:1]]){
        [climateList appendString:@"Warm, "];
    }
    if ([_phyloElement.hot isEqualToNumber:[NSNumber numberWithInt:1]]){
        [climateList appendString:@"Hot "];
    }
    _climates_label.text = climateList;
    
    NSMutableString *creature_classification = [[NSMutableString alloc]init];
    [creature_classification appendString:_phyloElement.kingdom];
    [creature_classification appendString:@", "];
    [creature_classification appendString:_phyloElement.phylum];
    [creature_classification appendString:@", "];
    [creature_classification appendString:_phyloElement.creature_class];
    _classification_label.text = creature_classification;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button addTarget:self action:@selector(cropImage) forControlEvents:UIControlEventTouchUpInside];
	[button setFrame:CGRectMake(15.0, 320.0, 100.0, 37.0)];
	[button setTitle:@"Crop Image" forState:UIControlStateNormal];
    
    [[self view] addSubview:button];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cropImage {
    
	ImageCropper *cropper = [[ImageCropper alloc] initWithImage:_phyloCardImage.image];
	[cropper setDelegate:self];
	
	[self presentViewController:cropper animated:YES completion:nil];
	
}

- (IBAction)edit_button_clicked:(id)sender{
    PXEditCardViewController *detailEdit = [[PXEditCardViewController alloc] init];
    detailEdit.phyloElement = _phyloElement;
    [self.navigationController pushViewController:detailEdit animated:YES];
    
}

#pragma imageCoper delegate

- (void)imageCropper:(ImageCropper *)cropper didFinishCroppingWithImage:(UIImage *)croppedImage
{
    //    NSLog(@"delegate");
    PXAppDelegate *appDelegate = (PXAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context=appDelegate.managedObjectContext;
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:context];
    [request setEntity:entity];
    
    NSError *errorFetch = nil;
    NSArray *array = [context executeFetchRequest:request error:&errorFetch];
       // NSLog(@"array size %d",array.count);
    for(Photo *p in array){
        if(p.image==self.image){
            p.image=croppedImage;
                    //    NSLog(@"image saved");
            _phyloCardImage.image=croppedImage;
            _phyloElement.thumbnail = croppedImage;
        }
    }
    
    NSError *error;
    if (![context save:&error]) {
               // NSLog(@"Failed to save - error: %@", [error localizedDescription]);
    }
}

- (void)imageCropperDidCancel:(ImageCropper *)cropper
{
    // to do
}

@end
