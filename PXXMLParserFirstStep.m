//
//  PXXMLParserFirstStep.m
//  Phylodex
//
//  Created by Daniel Hua on 13-7-2.
//  Copyright (c) 2013年 Phylosoft. All rights reserved.
//

#import "PXXMLParserFirstStep.h"

@implementation PXXMLParserFirstStep

@synthesize animalNameArray, xmlParser;

- (NSMutableArray *) ParseNameArray: (NSString *) data {
    NSData *dataString = [[NSData alloc]init];
    dataString = [data dataUsingEncoding:NSUTF8StringEncoding];
    xmlParser = [[NSXMLParser alloc]initWithData:dataString];
    animalNameArray = [[NSMutableArray alloc] init];
    xmlParser.delegate = self;
    [xmlParser parse];
    return self.animalNameArray;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {

    if ([elementName isEqualToString:@"speciesSearchResult"]) {
        
        animalName = [[NSMutableDictionary alloc]init];
        
        
        
//SET THE INITIAL KEYS FOR THE FINAL RESULT ARRAY, ANY KEY YOU WANT YOU CAN SET HERE, FOR INITIALIZATION PURPOSE, PLEASE SET IT TO @"Not Exist" ALWAYS
//**************************************************************************************
        [animalName setObject:@"Not Exist" forKey:@"Name"];
        [animalName setObject:@"Not Exist" forKey:@"FoodComments"];
        [animalName setObject:@"Not Exist" forKey:@"UniqueID"];
        
        //the reason that program crashed is i set the value @"Not Exist" to a UIImage type
        [animalName setObject:@"Not Exist" forKey:@"Image"];
        
        [animalName setObject:@"Not Exist" forKey:@"Latin Name"];
        [animalName setObject:@"Not Exist" forKey:@"Kingdom"];
        [animalName setObject:@"Not Exist" forKey:@"Phylum"];
        [animalName setObject:@"Not Exist" forKey:@"Class"];
        [animalName setObject:@"Not Exist" forKey:@"Order"];
        [animalName setObject:@"Not Exist" forKey:@"Family"];
        [animalName setObject:@"Not Exist" forKey:@"Genus"];
        [animalName setObject:@"Not Exist" forKey:@"EconomicComments"];
        [animalName setObject:@"Not Exist" forKey:@"ShortGeneralDescription"];
        [animalName setObject:@"Not Exist" forKey:@"ReproductionComments"];
        [animalName setObject:@"Not Exist" forKey:@"Habitat"];
        [animalName setObject:@"Not Exist" forKey:@"FoodComments"];
        [animalName setObject:@"Not Exist" forKey:@"CopyrightsHolder"];
//**************************************************************************************
        
        
        
    }
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
    
//  I have to eliminate all white spaces and newline characters in the currentElementVaue, or I cannot search with uniqueID in the second query
    NSString *currentElementValueString = [[NSString alloc] initWithString:[[currentElementValue componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:@""]];
    
    if ([elementName isEqualToString:@"commonName"]) {
        
//  when I store the name of animals, I have to take back white spaces, then I have to replace each capital letter with a whitespace + the capital letter
//  the drawback is, there is a whitespace before the first capital letter, which is the first character of the newString. Therefore, we need to fix it in later version
        NSMutableString *newString = [[NSMutableString alloc]initWithString:currentElementValueString];
        
//  check if there is any capital letter in the string, if it is then replace
        for (int i = 0; i < [newString length]; i++) {
            NSCharacterSet *upperCaseSet = [NSCharacterSet uppercaseLetterCharacterSet];
            if ([upperCaseSet characterIsMember:[newString characterAtIndex:i]] ) {
                
                NSRange range = [newString rangeOfComposedCharacterSequenceAtIndex:i];

                [newString replaceCharactersInRange:range withString:[[NSString alloc]initWithFormat:@" %c",[newString characterAtIndex:i]]];
                
//  when I finish replacing, I have to increment i by 1 because I increase he size of the newString by 1. I do it for the purpose of anti-infinite-for-loop
                i++;
            }
        }
        if (newString != nil) {
            [animalName setObject:newString forKey:@"Name"];
        }

    }
    if ([elementName isEqualToString:@"globalSpeciesUid"]) {
        if (currentElementValueString != nil) {
            [animalName setObject:currentElementValueString forKey:@"UniqueID"];
        }
    
    }
    if ([elementName isEqualToString:@"jurisdictionScientificName"]) {
        [animalName setObject:currentElementValueString forKey:@"Latin Name"];
    }
    if ([elementName isEqualToString:@"speciesSearchResult"]) {
        [animalNameArray addObject:animalName];
    }
    if ([elementName isEqualToString:@"speciesSearchResultList"]) {
        return;
    }
    currentElementValue = nil;
}

- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSString *errorString = [NSString stringWithFormat:@"Error code %i", [parseError code]];
    NSLog(@"Error parsing XML: %@", errorString);
}

@end
