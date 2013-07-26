//
//  Phylodex.m
//  Phylodex
//
//  Created by Artha on 13-7-14.
//  Copyright (c) 2013年 Phylosoft. All rights reserved.
//

#import "Phylodex.h"
#import "Photo.h"


@implementation Phylodex

@dynamic artist;
@dynamic date;
@dynamic thumbnail;
@dynamic photo;

@dynamic name;
@dynamic scientific_name;

@dynamic phylum;
@dynamic kingdom;
@dynamic creature_class;

@dynamic diet;
@dynamic heirarchy;
@dynamic creature_size;

@dynamic climate;
@dynamic cold;
@dynamic cool;
@dynamic warm;
@dynamic hot;

@dynamic habitat;
@dynamic habitat2;
@dynamic habitat3;

@dynamic points;

-(void) fixPoints{
    
    int total_climate_count = 0;
    total_climate_count += [self.cold intValue];
    total_climate_count += [self.cool intValue];
    total_climate_count += [self.warm intValue];
    total_climate_count += [self.hot intValue];
    int newPoints = 0;
    if(total_climate_count >2){
        newPoints--;
    }
    else if(total_climate_count < 2){
        newPoints++;
    }
    
    if ([self.habitat isEqualToString:self.habitat2]){
        if([self.habitat isEqualToString:self.habitat3]){
            newPoints++; //total_habitat_count = 1
        }
    }
    else if(![self.habitat isEqualToString:self.habitat3]){
        if (![self.habitat2 isEqualToString:self.habitat3]){
            newPoints--; //total_habitat_count = 3
        }
    }
    
    if ([self.diet isEqualToString:@"carnivore"]){
        newPoints += 7;
    }
    else if([self.diet isEqualToString:@"omnivore"]){
        newPoints += 3;
    }
    else if([self.diet isEqualToString:@"herbivore"]){
        newPoints += 4;
    }
    else if([self.diet isEqualToString:@"photosynthetic"]){
        newPoints += 2;
    }
    self.points = [NSString stringWithFormat:@"%d", newPoints];
}

@end
