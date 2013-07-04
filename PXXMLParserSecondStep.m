//
//  PXXMLParserSecondStep.m
//  Phylodex
//
//  Created by Daniel Hua on 13-7-3.
//  Copyright (c) 2013年 Phylosoft. All rights reserved.
//

#import "PXXMLParserSecondStep.h"

@implementation PXXMLParserSecondStep

@synthesize animalSpeciesArray, xmlParser, searchResultXMLData;

- (NSMutableArray *) ParseSpeciesArray: (NSMutableArray *)nameArray {
    
    animalSpeciesArray = [[NSMutableArray alloc] init];
    NSLog(@"nameArray count is: %lu", (unsigned long) [nameArray count]);
    int length = (unsigned long) [nameArray count];
    for (int i = 0; i < length; i++) {
        animalSpecies = [[NSMutableDictionary alloc]init];
        [animalSpecies setObject:[[nameArray objectAtIndex:i] objectForKey:@"Name"] forKey:@"Name"];
        [animalSpeciesArray addObject:animalSpecies];
//        [[animalSpeciesArray objectAtIndex:i] setObject:[[nameArray objectAtIndex:i]objectForKey:@"Name" ] forKey:@"Name"];
    }
    
    for (int i = 0; i < [nameArray count]; i++) {
        NSString *query = [[NSString alloc]initWithFormat:@"https://services.natureserve.org/idd/rest/ns/v1.1/globalSpecies/comprehensive?uid=%@&NSAccessKeyId=731c33b1-68ba-43f1-acb8-14fd4e0dcf0d",[[nameArray objectAtIndex:i] objectForKey:@"UniqueID"]];
        NSURL *url = [[NSURL alloc]initWithString:query];
        searchResultXMLData = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        NSData *dataString = [[NSData alloc]init];
        dataString = [searchResultXMLData dataUsingEncoding:NSUTF8StringEncoding];
        xmlParser = [[NSXMLParser alloc]initWithData:dataString];
        xmlParser.delegate = self;
        [xmlParser parse];
        NSLog(@"check once");
    }
    NSLog(@"self.animalSpeciesArray is: %@", self.animalSpeciesArray);
    return self.animalSpeciesArray;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if (!currentElementValue) {
        currentElementValue = [[NSMutableString alloc]initWithString:string];
    }
    else {
        [currentElementValue appendString:string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"foodComments"]) {
        [animalSpecies setObject:currentElementValue forKey:@"Species"];
        NSLog(@"%@", animalSpecies);
    }
    if ([elementName isEqualToString:@"globalSpecies"]) {
        return;
    }
    
    currentElementValue = nil;
}

- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSString *errorString = [NSString stringWithFormat:@"Error code %i", [parseError code]];
    NSLog(@"Error parsing XML: %@", errorString);
}
@end
