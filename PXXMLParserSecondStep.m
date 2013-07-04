//
//  PXXMLParserSecondStep.m
//  Phylodex
//
//  Created by Daniel Hua on 13-7-3.
//  Copyright (c) 2013年 Phylosoft. All rights reserved.
//

#import "PXXMLParserSecondStep.h"

@implementation PXXMLParserSecondStep

@synthesize xmlParser;

- (NSMutableDictionary *) ParseSpeciesArray: (NSData *)xmldata :(NSString *)name {
    
    animalSpecies = [[NSMutableDictionary alloc]init];
    [animalSpecies setObject:name forKey:@"Name"];

    xmlParser = [[NSXMLParser alloc]initWithData:xmldata];
    xmlParser.delegate = self;
    [xmlParser parse];
    
    return animalSpecies;
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
    
//  what does "species" need? what kind of data in the xml file? please check it
    if ([elementName isEqualToString:@"kingdom"]) {
        NSString *currentElementValueString = [[NSString alloc] initWithString:[[currentElementValue componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""]];
        [animalSpecies setObject:currentElementValueString forKey:@"Species"];
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
