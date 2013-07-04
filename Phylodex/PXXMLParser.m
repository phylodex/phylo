//
//  PXXMLParser.m
//  Phylodex
//
//  Created by Steve King on 2013-06-21.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXXMLParser.h"

@implementation PXXMLParser

@synthesize xmlParser;
@synthesize animalArray;

//@synthesize resultItems;

+ (NSMutableArray *)extractItemsFromXMLData:(NSString *)data
{
    // TO-DO: extract data from the xml data file into an NSMutableArray of NSDictionary objects for each unique result
    NSMutableArray *firstStepResults = [[NSMutableArray alloc] init];
    NSMutableArray *secondStepResults = [[NSMutableArray alloc] init];
    NSMutableArray *thirdStepResults = [[NSMutableArray alloc]init];
    NSMutableArray *results = [[NSMutableArray alloc] init];
    PXXMLParser *parser = [[PXXMLParser alloc]init];
    PXXMLParserFirstStep *nameArray = [[PXXMLParserFirstStep alloc]init];
    PXXMLParserSecondStep *speciesArray = [[PXXMLParserSecondStep alloc]init];
    PXXMLParserThirdStep *imageArray = [[PXXMLParserThirdStep alloc]init];
    firstStepResults = [nameArray ParseNameArray:data];
    secondStepResults = [speciesArray ParseSpeciesArray:firstStepResults];
    thirdStepResults = [imageArray ParseImageArray:secondStepResults];
    
//check the size of the dictionary
    NSData *checkDictionarySize = [NSPropertyListSerialization dataFromPropertyList:firstStepResults format:NSPropertyListBinaryFormat_v1_0 errorDescription:nil];
    
    results = [parser parseFile:firstStepResults: [checkDictionarySize length]];
    
    
    // for prototype version, just return some dummy data
//    NSMutableArray *results = [[NSMutableArray alloc] init];
//    PXDummyCollection *collection = [[PXDummyCollection alloc] init];
//    for (PXDummyModel *model in collection.dummyModels) {
//        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//        [dict setValue:model.name forKey:@"Name"];
//        [dict setValue:model.species forKey:@"Species"];
//        [dict setValue:model.image forKey:@"Image"];
//        [results addObject:dict];
//    }

    return results;
}

- (NSMutableArray *)parseFile:(NSMutableArray*) firstStepArray : (NSInteger) size{
    for (int i = 0; i < size; i++) {
        NSString *query = [[NSString alloc]initWithFormat:@"https://services.natureserve.org/idd/rest/ns/v1.1/globalSpecies/comprehensive?uid=%@&NSAccessKeyId=731c33b1-68ba-43f1-acb8-14fd4e0dcf0d",[firstStepArray objectAtIndex:i]];
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {

    
    
}

- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSString *errorString = [NSString stringWithFormat:@"Error code %i", [parseError code]];
    NSLog(@"Error parsing XML: %@", errorString);
}


@end
