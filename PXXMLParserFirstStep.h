//
//  PXXMLParserFirstStep.h
//  Phylodex
//
//  Created by Daniel Hua on 13-7-2.
//  Copyright (c) 2013年 Phylosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PXXMLParserFirstStep : NSObject <NSXMLParserDelegate> {
    NSXMLParser *xmlParser;
    NSMutableArray *animalNameArray;
    NSMutableDictionary *animalName;
    NSMutableString *currentElementValue;

}

@property (nonatomic, retain) NSXMLParser *xmlParser;
@property (nonatomic, retain) NSMutableArray *animalNameArray;

- (NSMutableArray *) parseNameArray: (NSString *) data;

@end
