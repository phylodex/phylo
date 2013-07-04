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

@end
