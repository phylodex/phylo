//
//  Phylodex.h
//  Phylodex
//
//  Created by Artha on 13-7-27.
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
@property (nonatomic, retain) NSString * habitat;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * point;
@property (nonatomic, retain) NSString * scale;
@property (nonatomic, retain) NSString * terrains;
@property (nonatomic, retain) id thumbnail;
@property (nonatomic, retain) Photo *photo;

@end
