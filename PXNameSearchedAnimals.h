//
//  PXNameSearchedAnimals.h
//  Phylodex
//
//  Created by Daniel Hua on 13-7-3.
//  Copyright (c) 2013年 Phylosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PXNameSearchedAnimals : NSObject {
    NSString *name;
    NSString *uniqueID;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *uniqueID;

@end
