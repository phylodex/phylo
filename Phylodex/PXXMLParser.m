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
    PXXMLParser *parser = [[PXXMLParser alloc]init];
    parser->firstStepResults = [[NSMutableArray alloc] init];
    parser->secondStepResults = [[NSMutableArray alloc]init];
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    PXXMLParserFirstStep *nameArray = [[PXXMLParserFirstStep alloc]init];
    
    parser->firstStepResults = [nameArray ParseNameArray:data];
    parser->secondStepResults = [parser parseFileSecondStep:parser->firstStepResults];
    parser->thirdStepResults = [parser parseFileThirdStep:parser->firstStepResults];
//    NSLog(@"secondStepResults is: %@", parser->secondStepResults);
    
    
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
    
    results = [parser parserMerge:parser];
    NSLog(@"result is: %@", results);
    return results;
}

- (NSMutableArray *)parseFileSecondStep:(NSMutableArray*) firstStepArray {
    int length = (unsigned long) [firstStepArray count];
    PXXMLParserSecondStep *speciesArray = [[PXXMLParserSecondStep alloc]init];
    
    for (int i = 0; i < length; i++) {
        NSString *query = [[NSString alloc]initWithFormat:@"https://services.natureserve.org/idd/rest/ns/v1.1/globalSpecies/comprehensive?uid=%@&NSAccessKeyId=731c33b1-68ba-43f1-acb8-14fd4e0dcf0d",[[firstStepArray objectAtIndex:i] objectForKey:@"UniqueID"]];
        NSURL *url = [[NSURL alloc]initWithString:query];
        NSString *searchResultXMLData = [[NSString alloc]initWithString:[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil]];
        NSData *dataString = [[NSData alloc]init];
        dataString = [searchResultXMLData dataUsingEncoding:NSUTF8StringEncoding];
        [secondStepResults addObject:[speciesArray ParseSpeciesArray:dataString:[[firstStepArray objectAtIndex:i]objectForKey:@"Name"]]];
    }

    return secondStepResults;
}

- (NSMutableArray *)parseFileThirdStep:(NSMutableArray*) firstStepArray {
    int length = (unsigned long) [firstStepArray count];
    PXXMLParserSecondStep *speciesArray = [[PXXMLParserSecondStep alloc]init];
    NSLog(@"get herer!!!!!!!");
    for (int i = 0; i < length; i++) {
        NSString *query = [[NSString alloc]initWithFormat:@"https://services.natureserve.org/idd/rest/ns/v1/globalSpecies/images?uid=%@",[[firstStepArray objectAtIndex:i] objectForKey:@"UniqueID"]];
        NSURL *url = [[NSURL alloc]initWithString:query];
        NSString *searchResultXMLData = [[NSString alloc]initWithString:[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil]];
        NSData *dataString = [[NSData alloc]init];
        dataString = [searchResultXMLData dataUsingEncoding:NSUTF8StringEncoding];
        [thirdStepResults addObject:[speciesArray ParseSpeciesArray:dataString:[[firstStepArray objectAtIndex:i]objectForKey:@"Name"]]];
//        NSLog(@"searchResultXMLData is: %@", searchResultXMLData);
    }
    
    return thirdStepResults;
}

- (NSMutableArray *)parserMerge: (PXXMLParser *) parser{
    int length = (unsigned long) [parser->firstStepResults count];
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < length; i++) {
        NSMutableDictionary *resultDictionary = [[NSMutableDictionary alloc]init];
        [resultDictionary setObject:[[parser->secondStepResults objectAtIndex:i] objectForKey:@"Name"] forKey:@"Name"];
        [resultDictionary setObject:[[parser->secondStepResults objectAtIndex:i] objectForKey:@"Species"] forKey:@"Species"];
        if (![[parser->thirdStepResults objectAtIndex:i] objectForKey:@"Image"]) {
        }
        else {
            [resultDictionary setObject:[[parser->thirdStepResults objectAtIndex:i] objectForKey:@"Image"] forKey:@"Image"];
            
        }
        [resultArray addObject:resultDictionary];
        NSLog(@"resultArray is: %@", resultArray);
    }
    return resultArray;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {

    
    
}

- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSString *errorString = [NSString stringWithFormat:@"Error code %i", [parseError code]];
    NSLog(@"Error parsing XML: %@", errorString);
}


@end
