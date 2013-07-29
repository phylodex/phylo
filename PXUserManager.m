//
//  PXUserManager.m
//  Phylodex
//
//  Created by Steve King on 2013-07-25.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXUserManager.h"
#import "PXAppDelegate.h"

@implementation PXUserManager

@synthesize currentUser, managedObjectContext, users;

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
    [self refreshUsers];
    return users;
}

- (void)refreshUsers
{
    PXAppDelegate *appDelegate = (PXAppDelegate *)[[UIApplication sharedApplication] delegate];
    managedObjectContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	
	// Order the entries by name
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"userID" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	
	// Execute the fetch -- create a mutable copy of the result.
	NSError *error = nil;
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	if (mutableFetchResults == nil) {
		// Handle the error.
	}
	users = mutableFetchResults;
}

// verify a password for a user and
- (BOOL)loginUserByUserID:(NSNumber *)userID withPassword:(NSString *)password
{
    [self refreshUsers];
    
    for (Users *aUser in users) {
        if ( [aUser.userID isEqualToNumber:userID] ) {
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

- (void)addUserWithUserName:(NSString *)userName andPassword:(NSString *)password andFullName:(NSString *)fullName
{
    [self refreshUsers];
    
    NSNumber *largestUserID = [self getLargestUserID];
    int value = [largestUserID intValue];
    NSNumber *newUserID = [NSNumber numberWithInt:value + 1];
    
    Users *newUser = (Users *)[NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:managedObjectContext];
    [newUser setFullName:fullName];
    [newUser setUserID:newUserID];
    [newUser setUserName:userName];
    [newUser setRole:@"user"];
    [newUser setPassword:password];
    
    // Commit the change.
	NSError *error = nil;
	if (![managedObjectContext save:&error]) {
		// Handle the error.
	}
}

- (void)removeUser:(Users *)user
{
    // Delete the managed object at the given index path.
    NSManagedObject *eventToDelete = (NSManagedObject *)user;
    [managedObjectContext deleteObject:eventToDelete];
    
    // Commit the change.
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        // Handle the error.
    }
    
}

- (void)updateUserWithUserID:(NSNumber *)userID withPassword:(NSString *)password withUserName:(NSString *)userName withFullName:(NSString *)fullName
{
    [self refreshUsers];
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID=%@", userID];
    [request setPredicate:predicate];
    
    NSError *errorFetch;
    NSArray *array = [managedObjectContext executeFetchRequest:request error:&errorFetch];
    
    Users *editUser = [array objectAtIndex:0];
    [editUser setPassword:password];
    [editUser setUserName:userName];
    [editUser setFullName:fullName];
    
    // Commit the change.
	NSError *error = nil;
	if (![managedObjectContext save:&error]) {
		// Handle the error.
	}
    
}

- (NSNumber *)getLargestUserID
{
    NSNumber *largest = [[NSNumber alloc] initWithInt:0];
    
    for (Users *aUser in users) {
        if ( [largest compare:aUser.userID] == NSOrderedAscending ) {
            largest = aUser.userID;
        }
    }
    return largest;
}


@end
