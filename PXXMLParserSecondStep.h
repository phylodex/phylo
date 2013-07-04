//
//  PXXMLParserSecondStep.h
//  Phylodex
//
//  Created by Daniel Hua on 13-7-3.
//  Copyright (c) 2013年 Phylosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PXXMLParserSecondStep : NSObject <NSXMLParserDelegate> {
    NSXMLParser *xmlParser;
    NSMutableDictionary *animalSpecies;
    NSMutableString *currentElementValue;
}

@property (nonatomic, retain) NSXMLParser *xmlParser;

- (NSMutableDictionary *) ParseSpeciesArray: (NSData *)xmldata :(NSString *)name;
@end
