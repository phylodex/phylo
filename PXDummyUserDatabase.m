//
//  PXDummyUserDatabase.m
//  Phylodex
//
//  Created by Steve King on 2013-07-25.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXDummyUserDatabase.h"

@implementation PXDummyUserDatabase

@synthesize users;

- (id)init
{
    self = [super init];
    if (self) {
        // init a dummy user database
        // create a dummy admin, and dummy user
        PXDummyUser *dummyAdmin = [[PXDummyUser alloc] init];
        dummyAdmin.userName = @"Admin";
        dummyAdmin.userID = @"1";
        dummyAdmin.role = @"admin";
        dummyAdmin.password = @"secret";
        dummyAdmin.fullName = @"God";
        
        // create dummy regular user
        PXDummyUser *dummyUser = [[PXDummyUser alloc] init];
        dummyUser.userName = @"user";
        dummyUser.userID = @"2";
        dummyUser.role = @"user";
        dummyUser.password = @"secret";
        dummyUser.fullName = @"Fred Flintstone";
        
        users = [[NSArray alloc] initWithObjects:dummyAdmin, dummyUser, nil];
    }
    return self;
}



@end
