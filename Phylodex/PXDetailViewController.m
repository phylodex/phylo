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
    NSString *Kingdom;
    NSString *Phylum;
    NSString *classType;
    
    int pointValueFoodChain;
    NSArray *habitatArea;
    NSArray *colorArray;
}
@property (nonatomic,assign) BOOL wantHorizontal;

@end

@implementation PXDetailViewController {}

@synthesize phyloELement, photoElement;

@synthesize window;

@synthesize saveButton;
@synthesize imageView;
@synthesize image;
@synthesize delegate;
@synthesize scroller;
@synthesize scrollerView;
@synthesize pointColor;

//food chain slider
@synthesize foodChainSlider, scaleSlider;

//select segment
@synthesize creature_class, creature_kingdom, creature_phylum;

//textFiled
@synthesize nameOfCreature, habitatType, artistInfo, climate, climate2, climate3, terrain, terrain2, desc;

//UILable
@synthesize displayLabel, pointValue, foodChain, scaleNumber;

- (void) viewWillAppear:(BOOL)animated{
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [[self nameOfCreature]setDelegate:self];
        [[self habitatType]setDelegate:self];
        [[self artistInfo]setDelegate:self];
        [[self climate]setDelegate:self];
        [[self terrain]setDelegate:self];
        [[self desc]setDelegate:self];
        
        PXAppDelegate *appledelegate = [[UIApplication sharedApplication]delegate];
        context_phylo = [appledelegate managedObjectContext];
        
        //add save navigation bar item
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
        saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
        saveButton.enabled = YES;
        self.navigationItem.rightBarButtonItem = saveButton;
                
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //set background
    scroller.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"card_bg.png"]];

    //scroll view
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 1000)];
    [scroller addSubview:scrollerView];
    
    //separate the habitat part
    self.displayLabel.text = phyloELement.terrains;   //terrains contains 2 parts
    NSString *hab = [[NSString alloc]initWithFormat:@"%@", self.displayLabel.text];
    NSLog(@"The original terrain in core data is: %@", self.displayLabel.text);
    NSLog(@"The tranfered string hab is: %@", hab);
    NSArray *ha = [hab componentsSeparatedByString:@", "];
    self.habitatType.text = phyloELement.habitat;
    int counter = 0;
    for (NSString *i in ha) {   //load habitat and terrain data
        if (counter == 0) {
            self.terrain.text = [ha objectAtIndex: 0];
        }
        else if (counter == 1) {
            self.terrain2.text = [ha objectAtIndex: 1];
        }
        counter ++;
    }
    
    //separate the climate part
    self.displayLabel.text = phyloELement.climate;   //terrains contains 2 parts
    NSString *clim = [[NSString alloc]initWithFormat:@"%@", self.displayLabel.text];
    NSLog(@"The original climate in core data is: %@", self.displayLabel.text);
    NSLog(@"The tranfered string hab is: %@", clim);
    NSArray *cl = [clim componentsSeparatedByString:@", "];
    counter = 0;
    for (NSString *s in cl) {   //load the climate data
        if (counter == 0) {
            self.climate.text = [cl objectAtIndex: 0];
        }
        if (counter == 1) {
            self.climate2.text = [cl objectAtIndex: 1];
        }
        if (counter == 2) {
            self.climate3.text = [cl objectAtIndex: 2];
        }
        counter ++;
    }
    
    //separate the evolutionary string
    self.displayLabel.text = phyloELement.evolutionary;
    NSString *evol = [[NSString alloc]initWithFormat:@"%@", self.displayLabel.text];
    NSLog(@"The original evolutionary in core data is: %@", self.displayLabel.text);
    NSLog(@"The tranfered string evol is: %@", evol);
    NSArray *arr = [evol componentsSeparatedByString:@", "];
    for (NSString *i in arr) {
        NSLog(@"the value in evolutionary tree is: %@", i);
        //set default value to UISegmentControl
        // From Ethan's code
        if ([i isEqualToString: @"Animalia"]){ creature_kingdom.selectedSegmentIndex = 0;}
        if ([i isEqualToString:@"Plantae"]){ creature_kingdom.selectedSegmentIndex = 1;}
        if ([i isEqualToString:@"Fungi"]){ creature_kingdom.selectedSegmentIndex = 2;}
        if ([i isEqualToString:@"Protista"]) { creature_kingdom.selectedSegmentIndex = 3;}
        if ([i isEqualToString:@"Chordata"]){ creature_phylum.selectedSegmentIndex = 0;}
        if ([i isEqualToString:@"Arthropoda"]){ creature_phylum.selectedSegmentIndex = 1;}
        if ([i isEqualToString:@"Annelida"]){ creature_phylum.selectedSegmentIndex = 2;}
        if ([i isEqualToString:@"Others"]){ creature_phylum.selectedSegmentIndex = 3;}
        if ([i isEqualToString:@"Aves"]){ creature_class.selectedSegmentIndex = 0;}
        if ([i isEqualToString:@"Amphibia"]){ creature_class.selectedSegmentIndex = 1;}
        if ([i isEqualToString:@"Mammalia"]){ creature_class.selectedSegmentIndex = 2;}
        if ([i isEqualToString:@"Reptilia"]){ creature_class.selectedSegmentIndex = 3;}
        if ([i isEqualToString:@"Others"]) { creature_class.selectedSegmentIndex = 4;}
        ///////////////////
    }

    //creature images
    imageView.image = self.image;
    //load data
    self.nameOfCreature.text = phyloELement.name; 
    self.artistInfo.text = phyloELement.artist;
    self.displayLabel.text = phyloELement.evolutionary;
    self.desc.text = phyloELement.desc;
    self.scaleNumber.text = phyloELement.scale;
    self.pointValue.text = phyloELement.point;
    
    colorArray = [NSArray arrayWithObjects:[UIColor yellowColor], [UIColor blackColor], [UIColor greenColor], [UIColor brownColor], [UIColor redColor], nil];
    self.pointColor.backgroundColor = [colorArray objectAtIndex:[phyloELement.foodChain integerValue]];
    self.foodChain.text = phyloELement.foodChain;
    foodChainSlider.value = [phyloELement.foodChain integerValue];
    scaleSlider.value = [phyloELement.scale integerValue];
    
//    self.displayLabel.hidden = TRUE;    //Please don't delete the displayLabel. If it is not in need, just hide it.
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

#pragma color&food chain number
- (IBAction)colorSliderChanged:(UISlider *)sender{
    pointColor.backgroundColor = [UIColor yellowColor];
    
    int process = lrint(sender.value);
    pointColor.backgroundColor = [colorArray objectAtIndex:process];
    self.foodChain.text = [NSString stringWithFormat:@"%d", process];
    // set the value for point to calculate
    if (process == 4){ pointValueFoodChain = 7; }
    else if (process == 3){ pointValueFoodChain = 3; }
    else if (process == 2){ pointValueFoodChain = 4; }
    else{ pointValueFoodChain = 2; }

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

            p.name = self.nameOfCreature.text;
            NSLog(@"p.name = %@", p.name);
            p.scale = self.scaleNumber.text;
            p.foodChain = self.foodChain.text;
            p.artist = self.artistInfo.text;
            p.climate = [NSString stringWithFormat:@"%@, %@, %@", self.climate.text, self.climate2.text, self.climate3.text];
            NSLog(@"%@", p.climate);
            
            p.habitat = self.habitatType.text;
            p.terrains = [NSString stringWithFormat:@"%@, %@", self.terrain.text, self.terrain2.text];

            NSLog(@"the terrains are %@, %@", self.terrain.text, self.terrain2.text);
            
            p.desc = self.desc.text;
            
            // From Ethan Code
            if(self.creature_kingdom.selectedSegmentIndex == 0){Kingdom = @"Animalia";}
            else if(self.creature_kingdom.selectedSegmentIndex == 1){Kingdom = @"Plantae";}
            else if(self.creature_kingdom.selectedSegmentIndex == 2){Kingdom = @"Fungi";}
            else {Kingdom = @"Protista";}
            
            if(self.creature_phylum.selectedSegmentIndex == 0){Phylum = @"Chordata";}
            else if(self.creature_phylum.selectedSegmentIndex == 1){Phylum = @"Anthropoda";}
            else if(self.creature_phylum.selectedSegmentIndex == 2){Phylum = @"Annelida";}
            else {Phylum = @"Others";}
            
            if(self.creature_class.selectedSegmentIndex == 0){classType = @"Aves";}
            else if(self.creature_class.selectedSegmentIndex == 1){classType = @"Amphbia";}
            else if(self.creature_class.selectedSegmentIndex == 2){classType = @"Mammalia";}
            else if(self.creature_class.selectedSegmentIndex == 3){classType = @"Reptilia";}
            else {classType = @"Others";}
            ////////////////////
            
            p.evolutionary = [NSString stringWithFormat:@"%@, %@, %@", Kingdom, Phylum, classType];
            self.displayLabel.text = p.evolutionary;
            
            NSLog(@"p.evolutionaryTree = %@", p.evolutionary);
            
            //calculate the points of the point value
            if ([habitatType.text length] > 0 && [terrain.text length] > 0 && [terrain2.text length] > 0)
            {   // no empty textfields
                if (habitatType.text == terrain.text && terrain.text == terrain2.text) {    //all habitats are the same
                    pointValueFoodChain += 1;
                }
                else if (habitatType.text != terrain.text && habitatType.text != terrain2.text && terrain.text != terrain2.text)
                {   // 3 different textfields
                    pointValueFoodChain -= 1;
                }

            }
            else if ([habitatType.text length] == 0 && [terrain.text length] == 0 && [terrain2.text length] == 0)
            {   // all textfields are empty. don't count this part
            }
            else if ([habitatType.text length] > 0 && [terrain2.text length] == 0 && [terrain.text length] == 0)
            {
                //only one empty textfield
                pointValueFoodChain += 1;
            }
            else if ([terrain.text length] > 0 && [terrain2.text length] == 0 && [habitatType.text length] == 0)
            {
                //only one empty textfield
                pointValueFoodChain += 1;
            }
            else if ([terrain2.text length] > 0 && [habitatType.text length] == 0 && [terrain.text length] == 0)
            {
                //only one empty textfield
                pointValueFoodChain += 1;
            }
            else
            {   // 2 empty textfields
                if (habitatType.text == terrain.text || habitatType.text == terrain2.text || terrain.text == terrain2.text)
                {
                    //1 empty textfield and 2 used textfields which are the same = 0
                    pointValueFoodChain += 1;
                }
            }
            
            if ([habitatType.text length] > 0 && [terrain.text length] > 0 && [terrain2.text length] > 0)
            {   // no empty textfields
                if (habitatType.text == terrain.text && terrain.text == terrain2.text) {    //all habitats are the same
                    pointValueFoodChain += 1;
                }
                else if (habitatType.text != terrain.text && habitatType.text != terrain2.text && terrain.text != terrain2.text)
                {   // 3 different textfields
                    pointValueFoodChain -= 1;
                }
                
            }
            else if ([climate.text length] == 0 && [climate2.text length] == 0 && [climate3.text length] == 0)
            {   // all textfields are empty. don't count this part
            }
            else if ([climate.text length] > 0 && [climate2.text length] == 0 && [climate3.text length] == 0)
            {
                //only one empty textfield
                pointValueFoodChain += 1;
            }
            else if ([climate2.text length] > 0 && [climate.text length] == 0 && [climate3.text length] == 0)
            {
                //only one empty textfield
                pointValueFoodChain += 1;
            }
            else if ([climate3.text length] > 0 && [climate2.text length] == 0 && [climate.text length] == 0)
            {
                //only one empty textfield
                pointValueFoodChain += 1;
            }
            else
            {   // 2 empty textfields
                if (climate.text == climate2.text || climate3.text == climate2.text || climate.text == climate3.text)
                {
                    //1 empty textfield and 2 used textfields which are the same = 0
                    pointValueFoodChain += 1;
                }
            }
            
            self.pointValue.text = [NSString stringWithFormat:@"%i", pointValueFoodChain];
            p.point = self.pointValue.text;
        }

        if(![context save:&errorFetch])
        {
            //NSLog(@"Failed to save - error: %@", [error localizedDescription]);
        }
    }
    else
    {
        NSLog(@"error in name");
    }

}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender{
    [nameOfCreature resignFirstResponder];
    [habitatType resignFirstResponder];
    [terrain resignFirstResponder];
    [terrain2 resignFirstResponder];
    [artistInfo resignFirstResponder];
    [climate resignFirstResponder];
    [climate2 resignFirstResponder];
    [climate3 resignFirstResponder];
    [desc resignFirstResponder];
}

@end
