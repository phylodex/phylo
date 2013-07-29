//
//  PXUserManager.h
//  Phylodex
//
//  Description: user to keep track of currently logged in users, and to update user
//               info in the user database. This class is a singleton, so the currently
//               logged in user can be accessed globally in the app.
//
//  Created by Steve King on 2013-07-25.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "PXDummyUser.h"
//#import "PXDummyUserDatabase.h"
#import "Users.h"

@interface PXUserManager : NSObject

+ (PXUserManager *)sharedInstance;

// return an array of all users
- (NSArray *)getUsers;

// return true if password is correct, false otherwise
- (BOOL)loginUserByUserID:(NSNumber *)userID withPassword:(NSString *)password;

// update a user in the database
- (void)updateUserWithUserID:(NSNumber *)userID withPassword:(NSString *)password withUserName:(NSString *)userName withFullName:(NSString *) fullName;

// logout current user and set current user to nil
- (void)logout;

// add a new user to the database of users
- (void)addUserWithUserName:(NSString *)userName andPassword:(NSString *)password andFullName:(NSString *)fullName;

// remove a user from the database
- (void)removeUser:(Users *)user;

@property (nonatomic, retain) Users *currentUser;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSArray *users;

@end
