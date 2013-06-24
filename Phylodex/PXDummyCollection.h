//
//  PXDummyCollection.h
//  Phylodex
//
//  Description: Prototype class used as to make a collection of dummy objects representing
//               user animals.
//
//  Created by Steve King on 2013-06-20.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXDummyModel.h"

@interface PXDummyCollection : NSObject

@property (nonatomic, retain)NSMutableArray *dummyModels;

@end
