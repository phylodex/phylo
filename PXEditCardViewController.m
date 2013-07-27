//
//  PXEditCardViewController.m
//  Phylodex
//
//  Created by ParkaPal on 2013-07-25.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXEditCardViewController.h"
#import "PXAppDelegate.h"

@interface PXEditCardViewController (){
        NSManagedObjectContext *context;
}

@end

@implementation PXEditCardViewController
@synthesize parent;


//run once on creation
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        [[self creature_name]setDelegate:self];
        [[self creature_sciname]setDelegate:self];
        
        PXAppDelegate *phylo = [[UIApplication sharedApplication]delegate];
        context = [phylo managedObjectContext];
        
        //add the save button to the nav bar
        UIBarButtonItem *btnSave = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Save"
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(save_button_clicked:)];
        self.navigationItem.rightBarButtonItem = btnSave;
        [self registerForKeyboardNotifications ];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    
    //set all the initial values from element passed by parent
    //names
    _creature_name.text = _phyloElement.name;
    _creature_sciname.text = _phyloElement.scientific_name;
    _creature_photog.text = _phyloElement.artist;
    
    //convert diet to index of control
    if([_phyloElement.diet isEqualToString:@"carnivore"]){
        _creature_diet.selectedSegmentIndex = 3;
    }
    else if([_phyloElement.diet isEqualToString:@"omnivore"]){
        _creature_diet.selectedSegmentIndex = 2;
    }
    else if([_phyloElement.diet isEqualToString:@"herbivore"]){
        _creature_diet.selectedSegmentIndex = 1;
    }
    else if([_phyloElement.diet isEqualToString:@"photosynthetic"]){
        _creature_diet.selectedSegmentIndex = 0;
    }
    
    //convert size to an index of control. This would be way easier if I could get ints properly assigned
    if([_phyloElement.creature_size isEqualToString:@"1"]){
        _creature_size.selectedSegmentIndex = 0;
    }
    else if([_phyloElement.creature_size isEqualToString:@"2"]){
        _creature_size.selectedSegmentIndex = 1;
    }
    else if([_phyloElement.creature_size isEqualToString:@"3"]){
        _creature_size.selectedSegmentIndex = 2;
    }
    else if([_phyloElement.creature_size isEqualToString:@"4"]){
        _creature_size.selectedSegmentIndex = 3;
    }
    else if([_phyloElement.creature_size isEqualToString:@"5"]){
        _creature_size.selectedSegmentIndex = 4;
    }
    else if([_phyloElement.creature_size isEqualToString:@"6"]){
        _creature_size.selectedSegmentIndex = 5;
    }
    else if([_phyloElement.creature_size isEqualToString:@"7"]){
        _creature_size.selectedSegmentIndex = 6;
    }
    else if([_phyloElement.creature_size isEqualToString:@"8"]){
        _creature_size.selectedSegmentIndex = 7;
    }
    else if([_phyloElement.creature_size isEqualToString:@"9"]){
        _creature_size.selectedSegmentIndex = 8;
    }
    
    //set switch state for climates
    if ([_phyloElement.cold isEqualToNumber:[NSNumber numberWithInt:1]]){
        _creature_cold.on = YES;
    }
    else{
        _creature_cold.on = NO;
    }
    if ([_phyloElement.cool isEqualToNumber:[NSNumber numberWithInt:1]]){
        _creature_cool.on = YES;
    }
    else{
        _creature_cool.on = NO;
    }
    if ([_phyloElement.warm isEqualToNumber:[NSNumber numberWithInt:1]]){
        _creature_warm.on = YES;
    }
    else{
        _creature_warm.on = NO;
    }
    if ([_phyloElement.hot isEqualToNumber:[NSNumber numberWithInt:1]]){
        _creature_hot.on = YES;
    }
    else{
        _creature_hot.on = NO;
    }
    
    
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
    
    //convert kingdom to index
    if ([_phyloElement.kingdom isEqualToString:@"Animalia"]){
        _creature_kingdom.selectedSegmentIndex = 0;
    }
    else if ([_phyloElement.kingdom isEqualToString:@"Plantae"]){
        _creature_kingdom.selectedSegmentIndex = 1;
    }
    else if ([_phyloElement.kingdom isEqualToString:@"Fungi"]){
        _creature_kingdom.selectedSegmentIndex = 2;
    }
    else{
        _creature_kingdom.selectedSegmentIndex = 3;
    }
    
    //convert phylum to index (Maybe add a text field for Other)
    if([_phyloElement.phylum isEqualToString:@"Chordata"]){
        _creature_phylum.selectedSegmentIndex = 0;
    }
    else if([_phyloElement.phylum isEqualToString:@"Arthropoda"]){
        _creature_phylum.selectedSegmentIndex = 1;
    }
    else if([_phyloElement.phylum isEqualToString:@"Annelida"]){
        _creature_phylum.selectedSegmentIndex = 2;
    }
    else {
        _creature_phylum.selectedSegmentIndex = 3;
    }
    
    //convert class to index (Maybe add a text field for Other)
    if([_phyloElement.creature_class isEqualToString:@"Aves"]){
        _creature_class.selectedSegmentIndex = 0;
    }
    else if([_phyloElement.creature_class isEqualToString:@"Amphibia"]){
        _creature_class.selectedSegmentIndex = 1;
    }
    else if([_phyloElement.creature_class isEqualToString:@"Mammalia"]){
        _creature_class.selectedSegmentIndex = 2;
    }
    else if([_phyloElement.creature_class isEqualToString:@"Reptilia"]){
        _creature_class.selectedSegmentIndex = 3;
    }
    else {
        _creature_class.selectedSegmentIndex = 4;
    }
    
    //set some UI visuals
    self.view.backgroundColor = [UIColor blackColor];
    self.view.backgroundColor = [[UIColor scrollViewTexturedBackgroundColor] colorWithAlphaComponent:0.8];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//this should be dismissing the keyboard but it doesn't seem to work right
- (IBAction)backgroundClick:(id)sender{
    NSLog(@"tapped bg");
    [self.creature_name resignFirstResponder];
    [self.creature_sciname resignFirstResponder];
}


- (IBAction)save_button_clicked:(id)sender {
    
    //update the current data
    //what to get from the db
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Phylodex" inManagedObjectContext:context];
    [request setEntity:entity];
    //actually get from the db
    NSError *errorFetch = nil;
    NSArray *array = [context executeFetchRequest:request error:&errorFetch];
    NSLog(@"%d", array.count); //how many entries
    //go through the possibilities
    for(Phylodex *newCreature in array){
        //only update to the entry that matches the entry we entered on
        if([newCreature.name isEqualToString: parent.phyloElement.name]){
            //update the names
            [newCreature setValue:self.creature_name.text forKey:@"name"];
            [newCreature setValue:self.creature_sciname.text forKey:@"scientific_name"];
            [newCreature setValue:self.creature_photog.text forKey:@"artist"];
            parent.phyloElement.name = newCreature.name;
            parent.phyloElement.scientific_name = newCreature.scientific_name;
            parent.phyloElement.artist = newCreature.artist;
            
            //update the diet with the right word for each index
            if(self.creature_diet.selectedSegmentIndex == 3){
                [newCreature setValue:@"carnivore" forKey:@"diet"];
                [newCreature setValue:@"3" forKey:@"heirarchy"];
            }
            else if(self.creature_diet.selectedSegmentIndex == 2){
                [newCreature setValue:@"omnivore" forKey:@"diet"];
                [newCreature setValue:@"3" forKey:@"heirarchy"];
            }
            else if(self.creature_diet.selectedSegmentIndex == 1){
                [newCreature setValue:@"herbivore" forKey:@"diet"];
                [newCreature setValue:@"2" forKey:@"heirarchy"];
            }
            else {
                [newCreature setValue:@"photosynthetic" forKey:@"diet"];
                [newCreature setValue:@"1" forKey:@"heirarchy"];
            }
            parent.phyloElement.diet = newCreature.diet;
            parent.phyloElement.heirarchy = newCreature.heirarchy;
            
            //update the size with the right value for each index (this would be easier if I could get int working right)
            switch(self.creature_size.selectedSegmentIndex){
                case 0:
                    [newCreature setValue:@"1" forKey:@"creature_size"];
                    break;
                case 1:
                    [newCreature setValue:@"2" forKey:@"creature_size"];
                    break;
                case 2:
                    [newCreature setValue:@"3" forKey:@"creature_size"];
                    break;
                case 3:
                    [newCreature setValue:@"4" forKey:@"creature_size"];
                    break;
                case 4:
                    [newCreature setValue:@"5" forKey:@"creature_size"];
                    break;
                case 5:
                    [newCreature setValue:@"6" forKey:@"creature_size"];
                    break;
                case 6:
                    [newCreature setValue:@"7" forKey:@"creature_size"];
                    break;
                case 7:
                    [newCreature setValue:@"8" forKey:@"creature_size"];
                    break;
                default:
                    [newCreature setValue:@"9" forKey:@"creature_size"];
            }
            parent.phyloElement.creature_size = newCreature.creature_size;
            
            //update the climate booleans with the right value for each switch
            [newCreature setValue:[NSNumber numberWithBool:self.creature_cold.on] forKey:@"cold"];
            [newCreature setValue:[NSNumber numberWithBool:self.creature_cool.on] forKey:@"cool"];
            [newCreature setValue:[NSNumber numberWithBool:self.creature_warm.on] forKey:@"warm"];
            [newCreature setValue:[NSNumber numberWithBool:self.creature_hot.on] forKey:@"hot"];
            parent.phyloElement.warm = newCreature.warm;
            parent.phyloElement.hot = newCreature.hot;
            parent.phyloElement.cool = newCreature.cool;
            parent.phyloElement.cold = newCreature.cold;

            
            //update the kingdom with the right word for each index
            if(self.creature_kingdom.selectedSegmentIndex == 0){
                [newCreature setValue:@"Animalia" forKey:@"kingdom"];
            }
            else if(self.creature_kingdom.selectedSegmentIndex == 1){
                [newCreature setValue:@"Plantae" forKey:@"kingdom"];
            }
            else if(self.creature_kingdom.selectedSegmentIndex == 2){
                [newCreature setValue:@"Fungi" forKey:@"kingdom"];
            }
            else {
                [newCreature setValue:@"Protista" forKey:@"kingdom"];
            }
            parent.phyloElement.kingdom = newCreature.kingdom;
            
            //update the phylum with the right word for each index (should support an 'other' text field in the future)
            if(self.creature_phylum.selectedSegmentIndex == 0){
                [newCreature setValue:@"Chordata" forKey:@"phylum"];
            }
            else if(self.creature_phylum.selectedSegmentIndex == 1){
                [newCreature setValue:@"Arthropoda" forKey:@"phylum"];
            }
            else if(self.creature_phylum.selectedSegmentIndex == 2){
                [newCreature setValue:@"Annelida" forKey:@"phylum"];
            }
            else {
                [newCreature setValue:@"Phylum" forKey:@"phylum"];
            }
            parent.phyloElement.phylum = newCreature.phylum;
            
            //update the class with the right word for each index (should support an 'other' text field in the future)
            if(self.creature_class.selectedSegmentIndex == 0){
                [newCreature setValue:@"Aves" forKey:@"creature_class"];
            }
            else if(self.creature_class.selectedSegmentIndex == 1){
                [newCreature setValue:@"Amphibia" forKey:@"creature_class"];
            }
            else if(self.creature_class.selectedSegmentIndex == 2){
                [newCreature setValue:@"Mammalia" forKey:@"creature_class"];
            }
            else if(self.creature_class.selectedSegmentIndex == 3){
                [newCreature setValue:@"Reptilia" forKey:@"creature_class"];
            }
            else {
                [newCreature setValue:@"Class" forKey:@"creature_class"];
            }
            parent.phyloElement.creature_class = newCreature.creature_class;
            
            //update the habitats with the right word for each index
            if(self.hab1.selectedSegmentIndex == 0){
                [newCreature setValue:@"desert" forKey:@"habitat"];
            }
            else if(self.hab1.selectedSegmentIndex == 1){
                [newCreature setValue:@"forest" forKey:@"habitat"];
            }
            else if(self.hab1.selectedSegmentIndex == 2){
                [newCreature setValue:@"freshwater" forKey:@"habitat"];
            }
            else if(self.hab1.selectedSegmentIndex == 3){
                [newCreature setValue:@"grasslands" forKey:@"habitat"];
            }
            else if(self.hab1.selectedSegmentIndex == 4){
                [newCreature setValue:@"ocean" forKey:@"habitat"];
            }
            else if(self.hab1.selectedSegmentIndex == 5){
                [newCreature setValue:@"tundra" forKey:@"habitat"];
            }
            else {
                [newCreature setValue:@"urban" forKey:@"habitat"];
            }
            parent.phyloElement.habitat = newCreature.habitat;
            
            if(self.hab2.selectedSegmentIndex == 0){
                [newCreature setValue:@"desert" forKey:@"habitat2"];
            }
            else if(self.hab2.selectedSegmentIndex == 1){
                [newCreature setValue:@"forest" forKey:@"habitat2"];
            }
            else if(self.hab2.selectedSegmentIndex == 2){
                [newCreature setValue:@"freshwater" forKey:@"habitat2"];
            }
            else if(self.hab2.selectedSegmentIndex == 3){
                [newCreature setValue:@"grasslands" forKey:@"habitat2"];
            }
            else if(self.hab2.selectedSegmentIndex == 4){
                [newCreature setValue:@"ocean" forKey:@"habitat2"];
            }
            else if(self.hab2.selectedSegmentIndex == 5){
                [newCreature setValue:@"tundra" forKey:@"habitat2"];
            }
            else {
                [newCreature setValue:@"urban" forKey:@"habitat2"];
            }
            parent.phyloElement.habitat2 = newCreature.habitat2;
            
            if(self.hab3.selectedSegmentIndex == 0){
                [newCreature setValue:@"desert" forKey:@"habitat3"];
            }
            else if(self.hab3.selectedSegmentIndex == 1){
                [newCreature setValue:@"forest" forKey:@"habitat3"];
            }
            else if(self.hab3.selectedSegmentIndex == 2){
                [newCreature setValue:@"freshwater" forKey:@"habitat3"];
            }
            else if(self.hab3.selectedSegmentIndex == 3){
                [newCreature setValue:@"grasslands" forKey:@"habitat3"];
            }
            else if(self.hab3.selectedSegmentIndex == 4){
                [newCreature setValue:@"ocean" forKey:@"habitat3"];
            }
            else if(self.hab3.selectedSegmentIndex == 5){
                [newCreature setValue:@"tundra" forKey:@"habitat3"];
            }
            else {
                [newCreature setValue:@"urban" forKey:@"habitat3"];
            }
            parent.phyloElement.habitat3 = newCreature.habitat3;
            
            //run fix on the points to match new data
            [newCreature fixPoints];
            
        }
        
    }
    
    NSError *error;
    [context save:&error];
    //  self.displayLabel.text = @"Info is updated!";
    //display alert on success
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save success!"
                                                    message:@"Your creature info has been updated."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


/******
 following should be for scrolling up view when keyboard is shown but is not perfect
 *****/


// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    _scroller.contentInset = contentInsets;
    _scroller.scrollIndicatorInsets = contentInsets;
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scroller.contentInset = contentInsets;
    _scroller.scrollIndicatorInsets = contentInsets;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _activeField = nil;
}


@end
