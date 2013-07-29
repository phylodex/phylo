//
//  Users.h
//  Phylodex
//
//  Created by Steve King on 2013-07-28.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Phylodex;

@interface Users : NSManagedObject

@property (nonatomic, retain) NSString * fullName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * role;
@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSSet *phylodex;
@end

@interface Users (CoreDataGeneratedAccessors)

- (void)addPhylodexObject:(Phylodex *)value;
- (void)removePhylodexObject:(Phylodex *)value;
- (void)addPhylodex:(NSSet *)values;
- (void)removePhylodex:(NSSet *)values;

@end
