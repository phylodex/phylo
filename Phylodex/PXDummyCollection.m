//
//  PXDummyCollection.m
//  Phylodex
//
//
//  Created by Steve King on 2013-06-20.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXDummyCollection.h"

@implementation PXDummyCollection

@synthesize dummyModels;

// This is ugly, but just to get interaction in the prototype working
- (id)init {
    // initialize a collection of dummy objects
    NSArray *animals = [NSArray arrayWithObjects:@"Gorilla", @"Bald Eagle", @"Dog", @"Lion", @"Horse", @"Gentoo Penguin", @"Housecat", nil];
    NSArray *sciNames = [NSArray arrayWithObjects:@"Gorilla Gorilla", @"Haliaeetus leucocephalus", @"Canis lupus familiaris", @"Panthera leo", @"Equus ferus caballus", @"Pygoscelis papua", @"Felis catus", nil];
    NSArray *classNames =[NSArray arrayWithObjects:@"Mammalia",@"Aves",@"Mammalia", @"Mammalia", @"Mammalia", @"Aves", @"Mammalia", nil];
    NSArray *diets =[NSArray arrayWithObjects:@"Herbivore",@"Carnivore",@"Omnivore", @"Carnivore", @"Herbivore", @"Carnivore", @"Carnivore", nil];
    NSArray *sizes =[NSArray arrayWithObjects:@"8",@"7",@"6", @"8", @"8", @"6", @"6", nil];
    dummyModels = [[NSMutableArray alloc] initWithCapacity:[animals count]];
    
    int counter = 0;
    for (NSString *animal in animals) {
        PXDummyModel *dummy = [PXDummyModel alloc];
        dummy.name = animal;
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", animal, @".png"]];
        dummy.image = image;
        dummy.species = [sciNames objectAtIndex:counter];
        dummy.phylum = @"Chordata";
        dummy.kingdom = @"Animalia";
        dummy.creature_class = [classNames objectAtIndex:counter];
        dummy.diet = [diets objectAtIndex:counter];
        if ([dummy.diet isEqualToString:@"Carnivore"] || [dummy.diet isEqualToString:@"Omnivore"]){
            dummy.heirarchy = @"3";
        }
        else if ([dummy.diet isEqualToString:@"Herbivore"]){
            dummy.heirarchy = @"2";
        }
        else if([dummy.diet isEqualToString:@"Photosynthetic"]){
            dummy.heirarchy = @"1";
        }
        dummy.creature_size = [sizes objectAtIndex:counter];
        counter++;
        [dummyModels addObject:dummy];
    }
    
    return self;
}

@end
