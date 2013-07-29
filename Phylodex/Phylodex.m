//
//  Phylodex.m
//  Phylodex
//
//  Created by Artha on 13-7-26.
//  Copyright (c) 2013年 Phylosoft. All rights reserved.
//

#import "Phylodex.h"
#import "Photo.h"


@implementation Phylodex

@dynamic artist;
@dynamic climate;
@dynamic desc;
@dynamic diet;
@dynamic evolutionary;
@dynamic foodChain;
@dynamic habitat;
@dynamic name;
@dynamic point;
@dynamic scale;
@dynamic terrains;
@dynamic thumbnail;
@dynamic photo;

/* IN PROGRESS
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
 */

@end
