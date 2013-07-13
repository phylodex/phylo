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

//- (NSMutableDictionary *)parseSpeciesArray:(NSData *)xmldata intoDictionary:(NSMutableDictionary *)name {
//    
//    animalSpecies = [[NSMutableDictionary alloc] initWithDictionary:name];
//
//    xmlParser = [[NSXMLParser alloc] initWithData:xmldata];
//    xmlParser.delegate = self;
//    [xmlParser parse];
//    
//    return animalSpecies;
//}

- (NSMutableDictionary *)parseSpeciesArray:(NSString *)data intoDictionary:(NSMutableDictionary *)name {
    animalSpecies = [[NSMutableDictionary alloc] initWithDictionary:name];
    NSData *dataString = [[NSData alloc] init];
    dataString = [data dataUsingEncoding:NSUTF8StringEncoding];
    xmlParser = [[NSXMLParser alloc] initWithData:dataString];
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
    

//THIS IS BASICALLY ALL INFORMATION CORRESPONDED WITH KEY-NAMES I INITIALIZED IN THE "PXXMLParserFirstStep.m" EXCEPT "Image" and "CopyrightsHolder" (YOU CAN FIND THEM IN "PXXMLParserThirdStep.m"), IF YOU WANT ADD ANY KEY-VALUE PAIR FROM "Global Comprehensive Species" SEARCHING RETURNED XML FILE, YOU CAN SIMPLY ADD IF STATEMENT HERE
//HOPING FOLLOWING EXPLANATION HELPS
//******************************************************************************************************
//******************************************************************************************************
    //if the identifier name (elementName in Xcode words) is the same as @"something you want" then do
    if ([elementName isEqualToString:@"kingdom"]) {
        //here simply delete all newline and whitespace characters in the currentElementValue (currentElementValue is the string between the 2 corresponed identifiers, eg. <name>Golden Eagle</name> then the currentElementValue wii be Golden Eagle)
        //however in some cases, you want a paragraph between the 2 corresponded identifiers, you can use
        //*********************************************************************************************
        //NSString *currentElementValueString = [[NSString alloc] initWithString:[[currentElementValue componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""]];
        //*********************************************************************************************
        //note that it becomes [NSCharacterSet newlineCharacterSet] not [NSCharacterSet whitespaceAndNewlineCharacterSet]
        //However for any currentElementValue I parsed from xml file, the format is:
        //"/n/t/n         Golden Eagle" please notice thoses whitespaces, if I only delete newline characters, it becomes "         Golden Eagle", but if I delete both characters(newline and whitespace), it becomes "GoldenEagle". unfortunately, I haven't a way to deal with that. hopefully you can find it
        NSString *currentElementValueString = [[NSString alloc] initWithString:[[currentElementValue componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:@""]];
        
        //here I just add the string to the corresponded key
        if (currentElementValueString != nil) {
            [animalSpecies setObject:currentElementValueString forKey:@"Kingdom"];
        }
    }
    
    if ([elementName isEqualToString:@"phylum"]) {
        NSString *currentElementValueString = [[NSString alloc] initWithString:[[currentElementValue componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:@""]];
        if (currentElementValueString != nil) {
            [animalSpecies setObject:currentElementValueString forKey:@"Phylum"];
        }
    }
    if ([elementName isEqualToString:@"class"]) {
        NSString *currentElementValueString = [[NSString alloc] initWithString:[[currentElementValue componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:@""]];
        if (currentElementValueString != nil) {
            [animalSpecies setObject:currentElementValueString forKey:@"Class"];
        }
    }
    if ([elementName isEqualToString:@"order"]) {
        NSString *currentElementValueString = [[NSString alloc] initWithString:[[currentElementValue componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:@""]];
        if (currentElementValueString != nil) {
            [animalSpecies setObject:currentElementValueString forKey:@"Order"];
        }
    }
    if ([elementName isEqualToString:@"family"]) {
        NSString *currentElementValueString = [[NSString alloc] initWithString:[[currentElementValue componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:@""]];
        if (currentElementValueString != nil) {
            [animalSpecies setObject:currentElementValueString forKey:@"Family"];
        }
    }
    if ([elementName isEqualToString:@"genus"]) {
        NSString *currentElementValueString = [[NSString alloc] initWithString:[[currentElementValue componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:@""]];
        if (currentElementValueString != nil) {
            [animalSpecies setObject:currentElementValueString forKey:@"Genus"];
        }
    }
    if ([elementName isEqualToString:@"economicComments"]) {
        NSString *currentElementValueString = [[NSString alloc] initWithString:[[currentElementValue componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""]];
        if (currentElementValueString != nil) {
            [animalSpecies setObject:currentElementValueString forKey:@"EconomicComments"];
        }
    }
    if ([elementName isEqualToString:@"shortGeneralDescription"]) {
        NSString *currentElementValueString = [[NSString alloc] initWithString:[[currentElementValue componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""]];
        if (currentElementValueString != nil) {
            [animalSpecies setObject:currentElementValueString forKey:@"ShortGeneralDescription"];
        }
    }
    if ([elementName isEqualToString:@"generalDescription"]) {
        NSString *currentElementValueString = [[NSString alloc] initWithString:[[currentElementValue componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""]];
        if (currentElementValueString != nil) {
            [animalSpecies setObject:currentElementValueString forKey:@"GeneralDescription"];
        }
    }
    if ([elementName isEqualToString:@"reproductionComments"]) {
        NSString *currentElementValueString = [[NSString alloc] initWithString:[[currentElementValue componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""]];
        if (currentElementValueString != nil) {
            [animalSpecies setObject:currentElementValueString forKey:@"ReproductionComments"];
        }
    }
    if ([elementName isEqualToString:@"habitat"]) {
        NSString *currentElementValueString = [[NSString alloc] initWithString:[[currentElementValue componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:@""]];
        if (currentElementValueString != nil) {
            if ([[animalSpecies objectForKey:@"Habitat"]isEqualToString:@"Not Exist"] == false) {
                NSString *addingHabitat = [[NSString alloc]initWithFormat:@"%@, %@",[animalSpecies objectForKey:@"Habitat"],currentElementValueString];
                [animalSpecies setObject:addingHabitat forKey:@"Habitat"];
            }
            else {
                [animalSpecies setObject:currentElementValueString forKey:@"Habitat"];
            }
            
        }
    }
    if ([elementName isEqualToString:@"foodComments"]) {
        NSString *currentElementValueString = [[NSString alloc] initWithString:[[currentElementValue componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""]];
        if (currentElementValueString != nil) {
            [animalSpecies setObject:currentElementValueString forKey:@"FoodComments"];
        }
    }
//******************************************************************************************************
//******************************************************************************************************
    
    
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
