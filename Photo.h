//
//  Photo.h
//  Phylodex
//
//  Created by Artha on 13-7-26.
//  Copyright (c) 2013年 Phylosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Phylodex;

@interface Photo : NSManagedObject

@property (nonatomic, retain) id image;
@property (nonatomic, retain) Phylodex *phylodex;

@end
