//
//  PXXMLParserThirdStep.m
//  Phylodex
//
//  Created by Daniel Hua on 13-7-3.
//  Copyright (c) 2013年 Phylosoft. All rights reserved.
//

#import "PXXMLParserThirdStep.h"

@implementation PXXMLParserThirdStep

@synthesize xmlParser;

- (NSMutableDictionary *) ParseImageArray: (NSData *)xmldata :(NSMutableDictionary *)name  {
    animalImage = [[NSMutableDictionary alloc]initWithDictionary:name];
    xmlParser = [[NSXMLParser alloc]initWithData:xmldata];
    foundImage = false;
    xmlParser.delegate = self;
    [xmlParser parse];
    
    
//ONE THING HERE IS, PLEASE SET UP A DEFAULT IMAGE THAT IF IMAGE DOES NOT EXIST ON THE SERVER, WE CAN PUT THIS IMAGE INSTEAD    
    if (foundImage == false) {
        //*******************************************************************
        //please put some default image setting code here
        //this code will be helpful:
        //[animalImage setObject:@"put default image here" forKey:@"Image"]
        //*******************************************************************
    }
    
    
    return animalImage;
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
    
//HERE IS THE "Image" AND "CopyrightsHolder" KEYS SETTINGS, IF YOU WANT TO ADD SOME INFORMATION FROM "Species Images" SEARCHING RETURNED XML FILE, YOU CAN ADD IF STATEMENT HERE
//I WILL ALSO EXPLAIN THE CODE A LITTLE BIT, HOPING THAT HELPS
//******************************************************************************************************
//******************************************************************************************************
    if ([elementName isEqualToString:@"dc:identifier"]) {
        //  get rid of whitespaces and newline characters
        NSString *currentElementValueString = [[NSString alloc] initWithString:[[currentElementValue componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:@""]];
        
        NSURL *imageURL = [NSURL URLWithString:currentElementValueString];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:imageData];
        if (image != nil) {
            [animalImage setObject:image forKey:@"Image"];
            foundImage = true;
        }
    }
    if ([elementName isEqualToString:@"dc:rightsHolder"]) {
        NSString *currentElementValueString = [[NSString alloc] initWithString:[[currentElementValue componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""]];
        if (currentElementValueString != nil) {
            [animalImage setObject:currentElementValueString forKey:@"CopyrightsHolder"];
        }
    }
//******************************************************************************************************
//******************************************************************************************************
    
    if ([elementName isEqualToString:@"image"]) {
        return;
    }
    
    currentElementValue = nil;
}

- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSString *errorString = [NSString stringWithFormat:@"Error code %i", [parseError code]];
    NSLog(@"Error parsing XML: %@", errorString);
}

@end
