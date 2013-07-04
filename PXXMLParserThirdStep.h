//
//  PXXMLParserThirdStep.h
//  Phylodex
//
//  Created by Daniel Hua on 13-7-3.
//  Copyright (c) 2013年 Phylosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PXXMLParserThirdStep : NSObject <NSXMLParserDelegate> {
    
}

- (NSMutableArray *) ParseImageArray: (NSMutableArray *) speciesArray;

@end
