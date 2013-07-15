//
//  Phylodex.h
//  Phylodex
//
//  Created by Artha on 13-7-14.
//  Copyright (c) 2013年 Phylosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;

@interface Phylodex : NSManagedObject

@property (nonatomic, retain) NSString * artist;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * habitat;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) id thumbnail;
@property (nonatomic, retain) Photo *photo;

@end
