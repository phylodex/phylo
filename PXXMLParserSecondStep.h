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
    NSMutableArray *animalSpeciesArray;
    NSMutableDictionary *animalSpecies;
    NSMutableString *currentElementValue;
}

@property (nonatomic, retain) NSXMLParser *xmlParser;
@property (nonatomic, retain) NSMutableArray *animalSpeciesArray;
@property (nonatomic, retain) NSString *searchResultXMLData;

- (NSMutableArray *) ParseSpeciesArray: (NSMutableArray *)nameArray;
@end
