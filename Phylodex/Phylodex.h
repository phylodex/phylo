//
//  Phylodex.h
//  Phylodex
//
//  Created by Steve King on 2013-06-30.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;

@interface Phylodex : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * habitat;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) UIImage *thumbnail;
@property (nonatomic, retain) Photo *photo;

@end
