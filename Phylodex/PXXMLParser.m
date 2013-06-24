//
//  PXXMLParser.m
//  Phylodex
//
//  Created by Steve King on 2013-06-21.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXXMLParser.h"

@implementation PXXMLParser

//@synthesize resultItems;

+ (NSMutableArray *)extractItemsFromXMLData:(NSString *)data
{
    // TO-DO: extract data from the xml data file into an NSMutableArray of NSDictionary objects for each unique result
    
    // for prototype version, just return some dummy data
    NSMutableArray *results = [[NSMutableArray alloc] init];
    PXDummyCollection *collection = [[PXDummyCollection alloc] init];
    for (PXDummyModel *model in collection.dummyModels) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setValue:model.name forKey:@"Name"];
        [dict setValue:model.species forKey:@"Species"];
        [dict setValue:model.image forKey:@"Image"];
        [results addObject:dict];
    }

    return results;
}

@end
