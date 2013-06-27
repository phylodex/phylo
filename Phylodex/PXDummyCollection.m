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
    NSArray *animals = [NSArray arrayWithObjects:@"Gorilla", @"Eagle", @"Dog",@"Deer", @"Lion", @"Penguin", @"Housecat", nil];
    dummyModels = [[NSMutableArray alloc] initWithCapacity:[animals count]];
    
    for (NSString *animal in animals) {
        PXDummyModel *dummy = [PXDummyModel alloc];
        dummy.name = animal;
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", animal, @".png"]];
        dummy.image = image;
        dummy.species = @"species";
        [dummyModels addObject:dummy];
    }
    
    return self;
}

@end
