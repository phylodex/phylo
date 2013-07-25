//
//  PXDummyModel.h
//  Phylodex
//
//  Description: A Dummy model used for prototyping, all values are hardcode. Primarily to
//               to test the interaction of the app for now.
//
//  Created by Steve King on 2013-06-20.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PXDummyModel : NSObject

@property (nonatomic, retain)UIImage *image;

@property (nonatomic, retain)NSString *name;
@property (nonatomic, retain)NSString *species;

@property (nonatomic, retain) NSString * kingdom;
@property (nonatomic, retain) NSString * phylum;
@property (nonatomic, retain) NSString * creature_class;

@property (nonatomic, retain) NSString * diet;
@property (nonatomic, retain) NSString * heirarchy;
@property (nonatomic, retain) NSString * creature_size;
@property (nonatomic, retain) NSString * climate;
@property (nonatomic, retain) NSString * habitat;
@property (nonatomic, retain) NSString * habitat2;
@property (nonatomic, retain) NSString * habitat3;

@end
