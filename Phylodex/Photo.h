//
//  Photo.h
//  Phylodex
//
//  Created by Steve King on 2013-06-30.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Phylodex;

@interface Photo : NSManagedObject

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) Phylodex *phylodex;

@end
