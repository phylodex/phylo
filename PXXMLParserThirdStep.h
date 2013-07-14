//
//  PXXMLParserThirdStep.h
//  Phylodex
//
//  Created by Daniel Hua on 13-7-3.
//  Copyright (c) 2013年 Phylosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PXXMLParserThirdStep : NSObject <NSXMLParserDelegate> {
    NSXMLParser *xmlParser;
    NSMutableDictionary *animalImage;
    NSMutableString *currentElementValue;
    Boolean foundImage;
}

@property (nonatomic, retain) NSXMLParser *xmlParser;

- (NSMutableDictionary *) parseImageArray: (NSString *)xmldata;

@end
