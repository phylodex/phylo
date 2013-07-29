//
//  Phylodex.h
//  Phylodex
//
//  Created by Steve King on 2013-07-28.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo, Users;

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
@property (nonatomic, retain) Users *user;

@end
