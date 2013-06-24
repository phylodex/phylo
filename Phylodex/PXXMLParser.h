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

// define the identifiers to extract info from the xml data
#define NAME_ID = @"name"
#define UUID_ID = @"uuid"

@interface PXXMLParser : NSObject

+ (NSMutableArray *)extractItemsFromXMLData:(NSString *)data;

@end
