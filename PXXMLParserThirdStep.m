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

- (NSMutableDictionary *) parseImageArray: (NSString *)data {
    animalImage = [[NSMutableDictionary alloc] init];
    foundImage = false;
    NSData *dataString = [[NSData alloc] init];
    dataString = [data dataUsingEncoding:NSUTF8StringEncoding];
    xmlParser = [[NSXMLParser alloc] initWithData:dataString];
    xmlParser.delegate = self;
    [xmlParser parse];
    
    //ONE THING HERE IS, PLEASE SET UP A DEFAULT IMAGE THAT IF IMAGE DOES NOT EXIST ON THE SERVER, WE CAN PUT THIS IMAGE INSTEAD    
    if (foundImage == false) {
        //*******************************************************************
        //please put some default image setting code here
        //this code will be helpful:
//        UIImage *image = [UIImage imageNamed:@"noimage.jpg"];
//        [animalImage setObject:image forKey:@"Image"];
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
        [animalImage setObject:currentElementValueString forKey:@"ImageURL"];
        
//        NSURL *imageURL = [NSURL URLWithString:currentElementValueString];
//        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
//        UIImage *image = [UIImage imageWithData:imageData];
//        if (image != nil) {
//            [animalImage setObject:image forKey:@"Image"];
//            foundImage = true;
//        }
    }
    if ([elementName isEqualToString:@"dc:rightsHolder"]) {
        NSString *currentElementValueString = [[NSString alloc] initWithString:[[currentElementValue componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:@""]];
        if ((currentElementValueString != nil) && ([currentElementValueString isEqualToString:@"CopyrightheldbyCreator"] == false)) {
            NSMutableString *newString = [[NSMutableString alloc]initWithString:currentElementValueString];
            for (int i = 0; i < [newString length]; i++) {
                NSCharacterSet *upperCaseSet = [NSCharacterSet uppercaseLetterCharacterSet];
                if ([upperCaseSet characterIsMember:[newString characterAtIndex:i]] ) {
                    
                    NSRange range = [newString rangeOfComposedCharacterSequenceAtIndex:i];
                    
                    [newString replaceCharactersInRange:range withString:[[NSString alloc]initWithFormat:@" %c",[newString characterAtIndex:i]]];
                    
                    i++;
                }
            }
            [animalImage setObject:newString forKey:@"CopyrightsHolder"];
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
