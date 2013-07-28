//
//  PXUserManager.m
//  Phylodex
//
//  Created by Steve King on 2013-07-25.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXUserManager.h"

@implementation PXUserManager

@synthesize currentUser;

- (id)init
{
    self = [super init];
    if (self) {
        currentUser = nil; // no user logged in yet
    }
    return self;
}


+ (PXUserManager *)sharedInstance
{
    // create singleton
    static dispatch_once_t onceToken;
    static PXUserManager *sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[PXUserManager alloc] init];
    });
    return sSharedInstance;
}

- (NSArray *)getUsers
{
    // return some dummy users for now
    // TO-DO: database integration
    PXDummyUserDatabase *users = [[PXDummyUserDatabase alloc] init];
    
    return users.users;
}

// verify a password for a user and
- (BOOL)loginUserByUserID:(NSString *)userID withPassword:(NSString *)password
{
    // TO-DO: database integration
    PXDummyUserDatabase *users = [[PXDummyUserDatabase alloc] init];
    
    for (PXDummyUser *aUser in users.users) {
        if ( [aUser.userID isEqualToString:userID]) {
            if ( [aUser.password isEqualToString:password] ) {
                // login correct
                currentUser = aUser; // set the found user to login
                return YES;
            }
        }
    }
    // user does not exist, or password incorrect
    currentUser = nil;
    return NO;
}

// logs out the current user, setting current user to nil
// the nil user is the "guest" user, and has its own public phylodex
- (void)logout
{
    currentUser = nil;
}

- (void)addUser:(PXDummyUser *)user
{
    // TO-DO: Database integration
}

- (void)removeUser:(PXDummyUser *)user
{
    // TO-DO: Database integration
}

- (void)updateUserWithUserID:(NSString *)userID withPassword:(NSString *)password withUserName:(NSString *)userName withFullName:(NSString *) fullName
{
    // TO-DO: Database integration
}


@end
