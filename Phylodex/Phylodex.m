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
@dynamic desc;
@dynamic diet;
@dynamic evolutionary;
@dynamic foodChain;
@dynamic name;
@dynamic scientific_name;
@dynamic point;
@dynamic scale;
@dynamic terrains;
@dynamic thumbnail;
@dynamic photo;

@dynamic climate;
@dynamic cold;
@dynamic cool;
@dynamic warm;
@dynamic hot;

@dynamic habitat;
@dynamic habitat2;
@dynamic habitat3;

@dynamic kingdom;
@dynamic phylum;
@dynamic creature_class;

/*
-(void) fixPoints{
    
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
-(void) fixPoints{
    
    int total_climate_count = 0;
    int total_habitat_count = 1;
    int newPoints = 0;

    total_climate_count += [self.cold intValue];
    total_climate_count += [self.cool intValue];
    total_climate_count += [self.warm intValue];
    total_climate_count += [self.hot intValue];
    if(total_climate_count >2){
        newPoints--;
    }
    else if(total_climate_count < 2){
        newPoints++;
    }
    
    //separate the climate part
    NSString *hab1 = self.habitat;
    NSString *hab2 = [[NSString alloc] init];
    NSString *hab3 = [[NSString alloc] init];
    NSString *hab = self.terrains;
    NSArray *habs = [hab componentsSeparatedByString:@", "];
    int counter2 = 0;
    for (NSString *s in habs) {   //load the habitat data
        if (counter2 == 0) {
            hab2 = [habs objectAtIndex: 0];
        }
        if (counter2 == 1) {
            hab3 = [habs objectAtIndex: 1];
        }
        counter2 ++;
    }
    //NSLog(@"%@ %@ %@", hab1,hab2,hab3);
    total_habitat_count += counter2;
    if(total_habitat_count  == 3){
        if ([hab1 isEqualToString:hab2]){
            if([hab1 isEqualToString:hab3]){
                newPoints++; //total 1 habitat
               // NSLog(@"Had 1 habitat, +1");
            }
        }
        else if(![hab1 isEqualToString:hab3]){
            if (![hab2 isEqualToString:hab3]){
                newPoints--; //total 3 habitat
      //          NSLog(@"Had 3 habitats, -1");
            }
        }
    }
    else if(total_habitat_count == 2){
        if([hab1 isEqualToString:hab2]){
            newPoints++; //total 1 habitat
        //    NSLog(@"Had 1 habitat, +1");
        }
    }
    else{
        newPoints++; //total 1 habitat
    //    NSLog(@"Had 1 habitat, +1");
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
    self.point = [NSString stringWithFormat:@"%d", newPoints];
}
 

@end
