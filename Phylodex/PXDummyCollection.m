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
    NSArray *diets =[NSArray arrayWithObjects:@"herbivore",@"carnivore",@"omnivore", @"carnivore", @"herbivore", @"carnivore", @"carnivore", nil];
    NSArray *habitat1s =[NSArray arrayWithObjects:@"forest",@"forest",@"urban", @"grasslands", @"grasslands", @"tundra", @"urban", nil];
    NSArray *habitat2s =[NSArray arrayWithObjects:@"forest",@"ocean",@"forest", @"grasslands", @"forest", @"tundra", @"forest", nil];
    NSArray *habitat3s =[NSArray arrayWithObjects:@"forest",@"freshwater",@"grasslands", @"grasslands", @"desert", @"ocean", @"grasslands", nil];
    NSArray *sizes =[NSArray arrayWithObjects:@"8",@"7",@"6", @"8", @"8", @"6", @"6", nil];
    NSArray *colds =[NSArray arrayWithObjects:@NO, @NO, @NO, @NO, @NO, @YES, @NO, nil];
    NSArray *cools =[NSArray arrayWithObjects:@NO, @YES, @YES, @NO, @YES, @NO, @YES, nil];
    NSArray *warms =[NSArray arrayWithObjects:@YES, @YES, @YES, @YES, @YES, @NO, @YES, nil];
    NSArray *hots =[NSArray arrayWithObjects:@YES, @NO, @NO, @YES, @YES, @NO, @NO, nil];
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
        if ([dummy.diet isEqualToString:@"carnivore"] || [dummy.diet isEqualToString:@"omnivore"]){
            dummy.heirarchy = @"3";
        }
        else if ([dummy.diet isEqualToString:@"herbivore"]){
            dummy.heirarchy = @"2";
        }
        else if([dummy.diet isEqualToString:@"photosynthetic"]){
            dummy.heirarchy = @"1";
        }
        dummy.creature_size = [sizes objectAtIndex:counter];
        
        dummy.cold = [colds objectAtIndex:counter];
        dummy.cool = [cools objectAtIndex:counter];
        dummy.warm = [warms objectAtIndex:counter];
        dummy.hot = [hots objectAtIndex:counter];
        
        dummy.habitat = [habitat1s objectAtIndex:counter];
        dummy.habitat2 = [habitat2s objectAtIndex:counter];
        dummy.habitat3 = [habitat3s objectAtIndex:counter];
        
        counter++;
        [dummyModels addObject:dummy];
    }
    
    return self;
}

@end
