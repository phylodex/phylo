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


-(void) fixPoints{
    
    int total_climate_count = 0;
    int total_habitat_count = 1;
    int newPoints = 0;

    //separate the climate part
    NSString *clim = self.climate;
    NSString *clim1 = [[NSString alloc] init];
    NSString *clim2 = [[NSString alloc] init];
    NSString *clim3 = [[NSString alloc] init];
    NSArray *cl = [clim componentsSeparatedByString:@", "];
    int counter = 0;
    for (NSString *s in cl) {   //load the climate data
        if (counter == 0) {
            clim1 = [cl objectAtIndex: 0];
        }
        if (counter == 1) {
            clim2 = [cl objectAtIndex: 1];
        }
        if (counter == 2) {
            clim3 = [cl objectAtIndex: 2];
        }
        counter ++;
    }
    NSLog(@"%@ %@ %@", clim1,clim2,clim3);
    total_climate_count += counter;
    if(total_climate_count  == 3){
        if ([clim1 isEqualToString:clim2]){
            if([clim1 isEqualToString:clim3]){
                newPoints++; //total 1 climate
                NSLog(@"Had 1 climate, +1");
            }
            else NSLog((@"had 2 climates A"));
        }
        else if(![clim1 isEqualToString:clim3]){
            if (![clim2 isEqualToString:clim3]){
                newPoints--; //total 3 climates
                NSLog(@"Had 3 climates, -1");
            }
            else NSLog((@"had 2 climates B"));
        }
    }
    else if(total_climate_count == 2){
        if([clim1 isEqualToString:clim2]){
            newPoints++; //total 1 climate
            NSLog(@"Had 1 climate, +1");
        }
        else  NSLog((@"had 2 climates C"));
    }
    else{
        newPoints++; //total 1 climate
        NSLog(@"Had 1 climate, +1");
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
    NSLog(@"%@ %@ %@", hab1,hab2,hab3);
    total_habitat_count += counter2;
    if(total_habitat_count  == 3){
        if ([hab1 isEqualToString:hab2]){
            if([hab1 isEqualToString:hab3]){
                newPoints++; //total 1 habitat
                NSLog(@"Had 1 habitat, +1");
            }
            else NSLog((@"had 2 habitats A"));
        }
        else if(![hab1 isEqualToString:hab3]){
            if (![hab2 isEqualToString:hab3]){
                newPoints--; //total 3 habitat
                NSLog(@"Had 3 habitats, -1");
            }
            else NSLog((@"had 2 habitats B"));
        }
    }
    else if(total_habitat_count == 2){
        if([hab1 isEqualToString:hab2]){
            newPoints++; //total 1 habitat
            NSLog(@"Had 1 habitat, +1");
        }
        else NSLog((@"had 2 habitats C"));
    }
    else{
        newPoints++; //total 1 habitat
        NSLog(@"Had 1 habitat, +1");
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
