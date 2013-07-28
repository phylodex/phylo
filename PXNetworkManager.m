//
//  PXNetworkManager.m
//  Phylodex
//
//  Created by Steve King on 2013-07-07.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXNetworkManager.h"

@implementation PXNetworkManager

@synthesize networkOperationCount;

+ (PXNetworkManager *)sharedInstance
{
    // create singleton
    static dispatch_once_t onceToken;
    static PXNetworkManager *sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[PXNetworkManager alloc] init];
    });
    return sSharedInstance;
}

- (void)didStartNetworkOperation
{
    assert([NSThread isMainThread]);
    networkOperationCount += 1;
}

- (void)didStopNetworkOperation
{
    assert([NSThread isMainThread]);
    assert(self.networkOperationCount > 0);
    networkOperationCount -= 1;
}

@end
