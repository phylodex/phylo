//
//  PXEditCardViewController.m
//  Phylodex
//
//  Created by ParkaPal on 2013-07-25.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXEditCardViewController.h"

@interface PXEditCardViewController ()

@end

@implementation PXEditCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //set some UI visuals
        self.view.backgroundColor = [UIColor blackColor];
        self.view.backgroundColor = [[UIColor                                                scrollViewTexturedBackgroundColor] colorWithAlphaComponent:0.8];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    _creature_name.text = _phyloElement.name;
    _creature_sciname.text = _phyloElement.scientific_name;
    if([_phyloElement.diet isEqualToString:@"carnivore"]){
        _creature_diet.selectedSegmentIndex = 3;
    }
    else if([_phyloElement.diet isEqualToString:@"omnivore"]){
        _creature_diet.selectedSegmentIndex = 2;
    }
    else if([_phyloElement.diet isEqualToString:@"herbivore"]){
        _creature_diet.selectedSegmentIndex = 1;
    }
    else if([_phyloElement.diet isEqualToString:@"autotroph"]){
        _creature_diet.selectedSegmentIndex = 0;
    }
    
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
   // .contentSize = CGSizeMake(320,500);
    
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
