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
//@synthesize foodChainSlider, scaleSlider;
@synthesize diet_selection, size_bar;

//select segment
@synthesize creature_class, creature_kingdom, creature_phylum;

//textFiled
@synthesize nameOfCreature, sci_name, habitatType, artistInfo;
//climate, climate2, climate3,
@synthesize terrain, terrain2, desc;

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
    [scroller setContentSize:CGSizeMake(320, 1100)];
    [scroller addSubview:scrollerView];
    
    //separate the habitat part
    self.displayLabel.text = phyloELement.terrains;   //terrains contains 2 parts
    NSString *hab = [[NSString alloc]initWithFormat:@"%@", self.displayLabel.text];
    //NSLog(@"The original terrain in core data is: %@", self.displayLabel.text);
    //NSLog(@"The tranfered string hab is: %@", hab);
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
    
    
    
    //set switch state for climates
    if ([phyloELement.cold isEqualToNumber:[NSNumber numberWithInt:1]]){
        _cold_switch.on = YES;
    }
    else{
        _cold_switch.on = NO;
    }
    if ([phyloELement.cool isEqualToNumber:[NSNumber numberWithInt:1]]){
        _cool_switch.on = YES;
    }
    else{
        _cool_switch.on = NO;
    }
    if ([phyloELement.warm isEqualToNumber:[NSNumber numberWithInt:1]]){
        _warm_switch.on = YES;
    }
    else{
        _warm_switch.on = NO;
    }
    if ([phyloELement.hot isEqualToNumber:[NSNumber numberWithInt:1]]){
        _hot_switch.on = YES;
    }
    else{
        _hot_switch.on = NO;
    }
    
    /*
    //convert habitats to index selections
    if([_phyloElement.habitat isEqualToString:@"desert"]){
        _hab1.selectedSegmentIndex = 0;
    }
    else if([_phyloElement.habitat isEqualToString:@"forest"]){
        _hab1.selectedSegmentIndex = 1;
    }
    else if([_phyloElement.habitat isEqualToString:@"freshwater"]){
        _hab1.selectedSegmentIndex = 2;
    }
    else if([_phyloElement.habitat isEqualToString:@"grasslands"]){
        _hab1.selectedSegmentIndex = 3;
    }
    else if([_phyloElement.habitat isEqualToString:@"ocean"]){
        _hab1.selectedSegmentIndex = 4;
    }
    else if([_phyloElement.habitat isEqualToString:@"tundra"]){
        _hab1.selectedSegmentIndex = 5;
    }
    else if([_phyloElement.habitat isEqualToString:@"urban"]){
        _hab1.selectedSegmentIndex = 6;
    }
    
    if([_phyloElement.habitat2 isEqualToString:@"desert"]){
        _hab2.selectedSegmentIndex = 0;
    }
    else if([_phyloElement.habitat2 isEqualToString:@"forest"]){
        _hab2.selectedSegmentIndex = 1;
    }
    else if([_phyloElement.habitat2 isEqualToString:@"freshwater"]){
        _hab2.selectedSegmentIndex = 2;
    }
    else if([_phyloElement.habitat2 isEqualToString:@"grasslands"]){
        _hab2.selectedSegmentIndex = 3;
    }
    else if([_phyloElement.habitat2 isEqualToString:@"ocean"]){
        _hab2.selectedSegmentIndex = 4;
    }
    else if([_phyloElement.habitat2 isEqualToString:@"tundra"]){
        _hab2.selectedSegmentIndex = 5;
    }
    else if([_phyloElement.habitat2 isEqualToString:@"urban"]){
        _hab2.selectedSegmentIndex = 6;
    }
    
    if([_phyloElement.habitat3 isEqualToString:@"desert"]){
        _hab3.selectedSegmentIndex = 0;
    }
    else if([_phyloElement.habitat3 isEqualToString:@"forest"]){
        _hab3.selectedSegmentIndex = 1;
    }
    else if([_phyloElement.habitat3 isEqualToString:@"freshwater"]){
        _hab3.selectedSegmentIndex = 2;
    }
    else if([_phyloElement.habitat3 isEqualToString:@"grasslands"]){
        _hab3.selectedSegmentIndex = 3;
    }
    else if([_phyloElement.habitat3 isEqualToString:@"ocean"]){
        _hab3.selectedSegmentIndex = 4;
    }
    else if([_phyloElement.habitat3 isEqualToString:@"tundra"]){
        _hab3.selectedSegmentIndex = 5;
    }
    else if([_phyloElement.habitat3 isEqualToString:@"urban"]){
        _hab3.selectedSegmentIndex = 6;
    }
    */
    
    //separate the evolutionary string
    self.displayLabel.text = phyloELement.evolutionary;
    NSString *evol = [[NSString alloc]initWithFormat:@"%@", self.displayLabel.text];
    //NSLog(@"The original evolutionary in core data is: %@", self.displayLabel.text);
    //NSLog(@"The tranfered string evol is: %@", evol);
    NSArray *arr = [evol componentsSeparatedByString:@", "];
    for (NSString *i in arr) {
        //NSLog(@"the value in evolutionary tree is: %@", i);
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
   // self.scaleNumber.text = phyloELement.scale;
    self.pointValue.text = phyloELement.point;
    self.sci_name.text = phyloELement.scientific_name;
    
    colorArray = [NSArray arrayWithObjects:[UIColor yellowColor], [UIColor blackColor], [UIColor greenColor], [UIColor brownColor], [UIColor redColor], nil];   
  //  self.pointColor.backgroundColor = [colorArray objectAtIndex:[phyloELement.foodChain integerValue]];
  //  self.foodChain.text = phyloELement.foodChain;
  //  foodChainSlider.value = [phyloELement.foodChain integerValue];
  //  scaleSlider.value = [phyloELement.scale integerValue];
    diet_selection.selectedSegmentIndex = [phyloELement.foodChain integerValue] - 1;
    if ([phyloELement.diet isEqualToString:@"carnivore"]){
        diet_selection.selectedSegmentIndex = 3;
    }
    size_bar.selectedSegmentIndex = [phyloELement.scale integerValue] - 1;
    
    
    nameOfCreature.delegate = self;
    sci_name.delegate = self;
    habitatType.delegate = self;
    artistInfo.delegate = self;
   // climate.delegate = self;
   // climate2.delegate = self;
   // climate3.delegate = self;
    terrain.delegate = self;
    terrain2.delegate = self;
    desc.delegate = self;
    nameOfCreature.returnKeyType = UIReturnKeyDone;
    sci_name.returnKeyType = UIReturnKeyDone;
    habitatType.returnKeyType = UIReturnKeyDone;
    artistInfo.returnKeyType = UIReturnKeyDone;
   // climate.returnKeyType = UIReturnKeyDone;
   // climate2.returnKeyType = UIReturnKeyDone;
   // climate3.returnKeyType = UIReturnKeyDone;
    terrain.returnKeyType = UIReturnKeyDone;
    terrain2.returnKeyType = UIReturnKeyDone;
    desc.returnKeyType = UIReturnKeyDone;
    
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

#pragma size value
- (IBAction)size_changed:(UISegmentedControl *)sender{
    phyloELement.scale = [NSString stringWithFormat:@"%d", (size_bar.selectedSegmentIndex +1)];
}

#pragma diet value
- (IBAction)diet_changed:(UISegmentedControl *)sender {
    phyloELement.foodChain = [NSString stringWithFormat:@"%d", diet_selection.selectedSegmentIndex];
    if(diet_selection.selectedSegmentIndex == 3){
        phyloELement.diet = @"carnivore";
    }
    else if(diet_selection.selectedSegmentIndex == 2){
        phyloELement.diet = @"omnivore";
    }
    else if(diet_selection.selectedSegmentIndex == 1){
        phyloELement.diet = @"herbivore";
    }
    else {
        phyloELement.diet = @"photosynthetic";
    }
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
    
    //NSLog(@"predictate is %@", predictate);
    
    NSError *errorFetch;
    NSArray *array = [context executeFetchRequest:request error:&errorFetch];
    
    if(array.count == 1) // update data
    {
        //NSLog(@"%d is found", array.count);
        for (Phylodex *p in array) {
            //NSLog(@"p is %@", p);

            p.name = self.nameOfCreature.text;
            p.scientific_name = self.sci_name.text;
            //NSLog(@"p.name = %@", p.name);
            p.scale = phyloELement.scale;
            p.foodChain = phyloELement.foodChain;
            p.diet = phyloELement.diet;
            p.artist = self.artistInfo.text;
           // p.climate = [NSString stringWithFormat:@"%@, %@, %@", self.climate.text, self.climate2.text, self.climate3.text];
            //NSLog(@"%@", p.climate);
            [p setValue:[NSNumber numberWithBool:self.cold_switch.on] forKey:@"cold"];
            [p setValue:[NSNumber numberWithBool:self.cool_switch.on] forKey:@"cool"];
            [p setValue:[NSNumber numberWithBool:self.warm_switch.on] forKey:@"warm"];
            [p setValue:[NSNumber numberWithBool:self.hot_switch.on] forKey:@"hot"];
            
            
            p.habitat = self.habitatType.text;
            p.terrains = [NSString stringWithFormat:@"%@, %@", self.terrain.text, self.terrain2.text];

            //NSLog(@"the terrains are %@, %@", self.terrain.text, self.terrain2.text);
            
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
            
            //NSLog(@"p.evolutionaryTree = %@", p.evolutionary);
            
            
            [p fixPoints];
            self.pointValue.text = p.point;
        }

        if(![context save:&errorFetch])
        {
            //NSLog(@"Failed to save - error: %@", [error localizedDescription]);
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save success!"
                                                         message:@"Your creature info has been updated."
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        NSLog(@"error in name");
    }

}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)backgroundTap:(id)sender{
    [nameOfCreature resignFirstResponder];
    [sci_name resignFirstResponder];
    [habitatType resignFirstResponder];
    [terrain resignFirstResponder];
    [terrain2 resignFirstResponder];
    [artistInfo resignFirstResponder];
   // [climate resignFirstResponder];
   // [climate2 resignFirstResponder];
   // [climate3 resignFirstResponder];
    [desc resignFirstResponder];
}

@end
