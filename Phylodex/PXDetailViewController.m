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

#import "PXDetailViewController.h"
#import "ImageCropper.h"
#import "Photo.h"
#import "PXAppDelegate.h"
@interface PXDetailViewController ()
{
    NSManagedObjectContext *context_phylo;
    NSString *evolutionaryTree;
    
    int pointValueFoodChain;
}

@end


@implementation PXDetailViewController {}

@synthesize phyloELement, photoElement;

@synthesize saveButton;
@synthesize imageView;
@synthesize image;
@synthesize delegate;
@synthesize scroller;
@synthesize scrollerView;
@synthesize pointColor;

//textFiled
@synthesize nameOfCreature, habitatType, artistInfo, climate, terrain, desc, evolutionary;

//UILable
@synthesize displayLabel, pointValue, foodChain, scaleNumber;

- (void) viewWillAppear:(BOOL)animated{
}

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
    
    //add save navigation bar item
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
	saveButton.enabled = YES;
    self.navigationItem.rightBarButtonItem = saveButton;
    
    //scroll view
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 1200)];
    [scroller addSubview:scrollerView];
    
    //creature images
    imageView.image = self.image;
    
    self.nameOfCreature.text = phyloELement.name;
    self.habitatType.text = phyloELement.habitat;
    self.terrain.text = phyloELement.terrains;   //terrain = habitat
    self.climate.text = phyloELement.climate;
    self.artistInfo.text = phyloELement.artist;
    self.evolutionary.text = phyloELement.evolutionary;
    self.desc.text = phyloELement.desc;
    
    [[self nameOfCreature]setDelegate:self];
    [[self habitatType]setDelegate:self];
    [[self artistInfo]setDelegate:self];
    [[self climate]setDelegate:self];
    [[self terrain]setDelegate:self];
    [[self evolutionary]setDelegate:self];
    [[self desc]setDelegate:self];
    
    PXAppDelegate *appledelegate = [[UIApplication sharedApplication]delegate];
    context_phylo = [appledelegate managedObjectContext];
    
}

- (IBAction)cropImage:(id)sender {
	ImageCropper *cropper = [[ImageCropper alloc] initWithImage:image];
	[cropper setDelegate:self];
	
	[self presentViewController:cropper animated:YES completion:nil];
	
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
    //    NSLog(@"array size %d",array.count);
    for(Photo *p in array){
        if(p.image==self.image){
            p.image=croppedImage;
            //            NSLog(@"image saved");
            self.imageView.image=croppedImage;
            self.phyloELement.thumbnail = croppedImage;
        }
    }
    
    NSError *error;
    if (![context save:&error]) {
        //        NSLog(@"Failed to save - error: %@", [error localizedDescription]);
    }
}

- (void)imageCropperDidCancel:(ImageCropper *)cropper{}

#pragma UISegmented Control
- (IBAction)toggleControls:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0){
        evolutionaryTree = [NSString stringWithFormat:@"Animallia, %@", evolutionary.text];
    }
    else{
        evolutionaryTree = [NSString stringWithFormat:@"Plantae, %@", evolutionary.text];
    }
    NSLog(@"evolutionary tree is %@", evolutionaryTree);
}

#pragma color&food chain number
- (IBAction)colorSliderChanged:(UISlider *)sender{
    pointColor.backgroundColor = [UIColor yellowColor];
    NSArray *colorArray = [NSArray arrayWithObjects:[UIColor yellowColor], [UIColor blackColor], [UIColor greenColor], [UIColor brownColor], [UIColor redColor], nil];
    int process = lrint(sender.value);
    pointColor.backgroundColor = [colorArray objectAtIndex:process];
    self.foodChain.text = [NSString stringWithFormat:@"%d", process];
    // set the value for point to calculate
    if (process == 4){ pointValueFoodChain = 7; }
    else if (process == 3){ pointValueFoodChain = 3; }
    else if (process == 2){ pointValueFoodChain = 4; }
    else{ pointValueFoodChain = 2; }
    
    self.pointValue.text = [NSString stringWithFormat:@"%i", pointValueFoodChain];
}

#pragma scale
- (IBAction)scaleSliderChanged:(UISlider *)sender {
    int process = lrint(sender.value);
    self.scaleNumber.text = [NSString stringWithFormat:@"%d", process];
}

#pragma save navigation bar button
- (void)save {
    
    //update data in core data
    
    //    NSLog(@"delegate");
    PXAppDelegate *appDelegate = (PXAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Phylodex" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entitydesc];
    
    NSPredicate *predictate = [NSPredicate predicateWithFormat:@"name like %@", phyloELement.name];
    [request setPredicate:predictate];
    
    NSLog(@"predictate is %@", predictate);
    
    NSError *errorFetch;
    NSArray *array = [context executeFetchRequest:request error:&errorFetch];
    
    if(array.count == 1) // update data
    {
        NSLog(@"%d is found", array.count);
        for (Phylodex *p in array) {
            NSLog(@"p is %@", p);
            NSLog(@"p.name = %@", p.name);
            p.name = self.nameOfCreature.text;
            NSLog(@"p.name = %@", p.name);
            p.scale = self.scaleNumber.text;
            p.artist = self.artistInfo.text;
            p.climate = self.climate.text;
            p.desc = self.desc.text;
            p.evolutionary = self.evolutionary.text;
            p.terrains = self.terrain.text;
        }
        
        if(![context save:&errorFetch])
        {
            //        NSLog(@"Failed to save - error: %@", [error localizedDescription]);
        }
        
    }
    else
    {
        NSLog(@"error in id");
    }
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender{
    [nameOfCreature resignFirstResponder];
    [habitatType resignFirstResponder];
    [artistInfo resignFirstResponder];
    [evolutionary resignFirstResponder];
    [climate resignFirstResponder];
    [terrain resignFirstResponder];
    [desc resignFirstResponder];
}


@end
