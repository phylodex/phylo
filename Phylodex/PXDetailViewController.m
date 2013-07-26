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
    
    [[self nameOfCreature]setDelegate:self];
    [[self habitatType]setDelegate:self];
    [[self artistInfo]setDelegate:self];
    [[self climate]setDelegate:self];
    [[self terrain]setDelegate:self];
    [[self evolutionary]setDelegate:self];
    [[self desc]setDelegate:self];
    
    PXAppDelegate *appledelegate = [[UIApplication sharedApplication]delegate];
    context_phylo = [appledelegate managedObjectContext];
    
    //--------------------------------
    // change date into normal string, but not for now
    //    NSDate* date = phyloELement.date;    //Create the dateformatter object
    //    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];    //Set the required date format
    //    [formatter setDateFormat:@"yyyy-MM-dd"];
    //    NSString* dateStr = [formatter stringFromDate:date];    //Get the string date
    //    NSLog(dateStr);   //Display on the console
    //--------------------------------
    
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
        evolutionaryTree = @"Animalia, %@", [evolutionary text];
    }
    else{
        evolutionaryTree = @"Plantae, %@", [evolutionary text];
    }
}

#pragma point value
- (IBAction)numberSliderChanged:(UISlider *)sender{
    int process = lrint(sender.value);
    self.pointValue.text = [NSString stringWithFormat:@"%d", process];
}

#pragma color
- (IBAction)colorSliderChanged:(UISlider *)sender{
    pointColor.backgroundColor = [UIColor yellowColor];
    NSArray *colorArray = [NSArray arrayWithObjects:[UIColor yellowColor], [UIColor blackColor], [UIColor greenColor], [UIColor brownColor], [UIColor redColor], nil];
    int process = lrint(sender.value);
    pointColor.backgroundColor = [colorArray objectAtIndex:process];
    self.foodChain.text = [NSString stringWithFormat:@"%d", process];
    
}

#pragma scale
- (IBAction)scaleSliderChanged:(UISlider *)sender {
    int process = lrint(sender.value);
    self.scaleNumber.text = [NSString stringWithFormat:@"%d", process];
}

#pragma save navigation bar button
- (void)save {
    
    //update data in core data
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Phylodex" inManagedObjectContext:context_phylo];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entitydesc];
    
//    NSPredicate *predictate = [NSPredicate predicateWithFormat:@"id like %d", phyloELement.id];
//    [request setPredicate:predictate];
    
    NSError *error;
    NSArray *matchingData = [context_phylo executeFetchRequest:request error:&error];
    
    if(matchingData.count == 1) // if there exists one
    {
        NSManagedObject *creature = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context_phylo];
        [creature setValue:self.nameOfCreature.text forKey:@"name"];
        [creature setValue:self.scaleNumber.text forKey:@"scale"];
        [creature setValue:self.artistInfo.text forKey:@"artist"];
        [creature setValue:self.climate.text forKey:@"climate"];
        [creature setValue:self.desc.text forKey:@"desc"];
        [creature setValue:self.pointColor.image forKey:@"diet"];
        [creature setValue:evolutionaryTree forKey:@"evolutionary"];        // animalia/plantae + evolutionary
        [creature setValue:self.foodChain.text forKey:@"foodChain"];
        [creature setValue:self.habitatType.text forKey:@"habitat"];
        [creature setValue:self.pointValue.text forKey:@"point"];
        [creature setValue:self.terrain.text forKey:@"terrains"];
        
    }
    else if (matchingData.count == 0){  //insert a new item
        NSManagedObject *newcreature = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context_phylo];
        [newcreature setValue:self.nameOfCreature.text forKey:@"name"];
        [newcreature setValue:self.scaleNumber.text forKey:@"scale"];
        [newcreature setValue:self.artistInfo.text forKey:@"artist"];
        [newcreature setValue:self.climate.text forKey:@"climate"];
        [newcreature setValue:self.desc.text forKey:@"desc"];
        [newcreature setValue:self.pointColor.image forKey:@"diet"];
        [newcreature setValue:evolutionaryTree forKey:@"evolutionary"];        // animalia/plantae + evolutionary
        [newcreature setValue:self.foodChain.text forKey:@"foodChain"];
        [newcreature setValue:self.habitatType.text forKey:@"habitat"];
        [newcreature setValue:self.pointValue.text forKey:@"point"];
        [newcreature setValue:self.terrain.text forKey:@"terrains"];
        
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
