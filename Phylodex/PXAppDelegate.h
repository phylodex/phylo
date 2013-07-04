//
//  PXAppDelegate.h
//  Phylodex
//
//  Description: Main app delegate, loads the tab bar view and modal views
//
//  Created by Steve King on 2013-06-18.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXRootViewController.h"
#import "PXWebSearchViewController.h"
#import "PXShareViewController.h"
#import "PXCameraViewController.h"

#define NUM_MODES 4 // how many modes in the tab bar controller

@interface PXAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *rootController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
