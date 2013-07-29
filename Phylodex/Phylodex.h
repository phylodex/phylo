//
//  Phylodex.h
//  Phylodex
//
//  Created by Artha on 13-7-26.
//  Copyright (c) 2013年 Phylosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;

@interface Phylodex : NSManagedObject

@property (nonatomic, retain) NSString * artist;
@property (nonatomic, retain) NSString * climate;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) id diet;
@property (nonatomic, retain) NSString * evolutionary;
@property (nonatomic, retain) NSString * foodChain;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * scientific_name;
@property (nonatomic, retain) NSString * point;
@property (nonatomic, retain) NSString * scale;
@property (nonatomic, retain) NSString * terrains;
@property (nonatomic, retain) id thumbnail;
@property (nonatomic, retain) Photo *photo;


@property (nonatomic, retain) NSString * habitat;
@property (nonatomic, retain) NSString * habitat2;
@property (nonatomic, retain) NSString * habitat3;

@property (nonatomic, retain) NSNumber * cold;
@property (nonatomic, retain) NSNumber * cool;
@property (nonatomic, retain) NSNumber * warm;
@property (nonatomic, retain) NSNumber * hot;

@property (nonatomic, retain) NSString * kingdom;
@property (nonatomic, retain) NSString * phylum;
@property (nonatomic, retain) NSString * creature_class;

- (void) fixPoints;
@end
