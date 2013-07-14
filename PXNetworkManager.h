//
//  PXNetworkManager.h
//  Phylodex
//
//  Description: A singleton class used to keep track of the count of concurrent network connections
//
//  Note: Adapted heavily from the Apple Sample project SimpleURLConnections by DTS
//        Copyright (c) 2009-2012 Apple Inc. All Rights Reserved.
//
//  Created by Steve King on 2013-07-07.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PXNetworkManager : NSObject

+ (PXNetworkManager *)sharedInstance;

@property (nonatomic, assign, readonly ) NSUInteger networkOperationCount;  // observable

- (void)didStartNetworkOperation;
- (void)didStopNetworkOperation;

@end
