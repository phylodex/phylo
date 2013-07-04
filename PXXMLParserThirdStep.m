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

- (NSMutableDictionary *) ParseImageArray: (NSData *)xmldata :(NSString *)name  {
    animalImage = [[NSMutableDictionary alloc]init];
    [animalImage setObject:name forKey:@"Name"];
    
    xmlParser = [[NSXMLParser alloc]initWithData:xmldata];
    xmlParser.delegate = self;
    [xmlParser parse];
    
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
    NSLog(@"get the method!!!!");
    //  what does "species" need? what kind of data in the xml file? please check it
    if ([elementName isEqualToString:@"dc:identifier"]) {
        
//  get rid of whitespaces and newline characters
        NSString *currentElementValueString = [[NSString alloc] initWithString:[[currentElementValue componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:@""]];
        NSURL *imageURL = [NSURL URLWithString:currentElementValueString];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:imageData];
        [animalImage setObject:image forKey:@"Image"];
        
        NSLog(@"animalImage is: %@", animalImage);
        return;
    }
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
