//
//  PXXMLParser.h
//  Phylodex
//
//  Description: Parses an XML file from natureserve.org, extracting pertinent info
//
//  Created by Steve King on 2013-06-21.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXDummyCollection.h"
#import "PXXMLParserFirstStep.h"
#import "PXXMLParserSecondStep.h"
#import "PXXMLParserThirdStep.h"

@class PXXMLParserFirstStep;
@class PXXMLParserSecondStep;
@class PXXMLParserThirdStep;

// define the identifiers to extract info from the xml data
#define NAME_ID = @"name"
#define UUID_ID = @"uuid"

@interface PXXMLParser : NSObject <NSXMLParserDelegate> {
    NSMutableArray *firstStepResults;
    NSMutableArray *secondStepResults;
    NSMutableArray *thirdStepResults;
}

+ (NSMutableArray *)extractItemsFromXMLData:(NSString *)data;
- (NSMutableArray *)parseFileSecondStep:(NSMutableArray *) firstStepArray;
- (NSMutableArray *)parseFileThirdStep:(NSMutableArray *) firstStepArray;
//- (NSMutableArray *)parserMerge: (PXXMLParser*) parser;
@end
