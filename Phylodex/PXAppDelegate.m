//
//  PXAppDelegate.m
//  Phylodex
//
//  Created by Steve King on 2013-06-18.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXAppDelegate.h"
#import "PXNetworkManager.h"
#import "PXDetailViewController.h"

@implementation PXAppDelegate
{
    char _networkOperationCountDummy;
    NSManagedObjectContext *context_phylo;
}

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // set the observed class
    [[PXNetworkManager sharedInstance] addObserver:self forKeyPath:@"networkOperationCount" options:NSKeyValueObservingOptionInitial context:&self->_networkOperationCountDummy];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    PXDetailViewController *detailViewController = [[PXDetailViewController alloc]init];
    [self.window setRootViewController:detailViewController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // set up the individual controllers for each mode
    NSMutableArray *controllers = [NSMutableArray array];
    
    // set up the modal view controllers
    PXRootViewController *phylodex = [[PXRootViewController alloc] init];
    PXWebSearchViewController *webSearch = [[PXWebSearchViewController alloc] init];
    PXCameraViewController *capture = [[PXCameraViewController alloc]init];
    PXLoginAreaViewController *user = [[PXLoginAreaViewController alloc] init];
    // to-do: collection view
    //PXShareViewController *share = [[PXShareViewController alloc] init];
    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [aFlowLayout setItemSize:CGSizeMake(90, 90)];
    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    aFlowLayout.sectionInset = UIEdgeInsetsMake(10.0,10.0,10.0,10.0);
    PXShareViewController *share = [[PXShareViewController alloc]initWithCollectionViewLayout:aFlowLayout];
    
    
    
    // add the modes to the controllers array
    UINavigationController *phylodexNav = [[UINavigationController alloc] initWithRootViewController:phylodex];
    [controllers addObject:phylodexNav];
    [controllers addObject:capture];
    UINavigationController *webSearchNav = [[UINavigationController alloc] initWithRootViewController:webSearch];
    [controllers addObject:webSearchNav];
    // to-do: make a collection view object
    UINavigationController *shareNav = [[UINavigationController alloc] initWithRootViewController:share];
    [controllers addObject:shareNav];
    UINavigationController *userNav = [[UINavigationController alloc] initWithRootViewController:user];
    [controllers addObject:userNav];
    
    NSManagedObjectContext *context = [self managedObjectContext];
	if (!context) {
		// Handle the error.
	}
	phylodex.managedObjectContext = context;
    
    
    // set up the tab bar controller
    _rootController = [[UITabBarController alloc] init];
    _rootController.viewControllers = controllers;
       
    // FOR DEVELOPMENT PURPOSES: populate with dummy data
    // insert dummy data only if database is empty already
    if (![self coreDataHasEntriesForEntityName:@"Phylodex"]) {
        [self populateDummyData];
    }
    
    _window.rootViewController = _rootController;
    [_window makeKeyAndVisible];
    
    return YES;
}

// FOR DEVELOPMENT PURPOSES!!!
// Populate the user data base with some items if they aren't there yet
- (void)populateDummyData
{
    // create the admin user
    Users *adminUser = (Users *)[NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:_managedObjectContext];
    [adminUser setFullName:@"Fred Flintstone"];
    [adminUser setUserID:[NSNumber numberWithInt:0]]; // admin is the zero user
    [adminUser setUserName:@"Admin"];
    [adminUser setRole:@"admin"];
    [adminUser setPassword:@""]; // empty password
    
    Users *user = (Users *)[NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:_managedObjectContext];
    [user setFullName:@"Buzz Alder"];
    [user setUserID:[NSNumber numberWithInt:1]];
    [user setUserName:@"buzz"];
    [user setRole:@"user"];
    [user setPassword:@"secret"];
    
    PXDummyCollection *collection = [[PXDummyCollection alloc] init];
    int i = 1; // user to alternate between assigning to user and admin
    // add each dummy entry into the user database
    for (PXDummyModel *model in collection.dummyModels) {
       
        Phylodex *phylo = (Phylodex *)[NSEntityDescription insertNewObjectForEntityForName:@"Phylodex" inManagedObjectContext:_managedObjectContext];
        Photo *photo = (Photo *)[NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:_managedObjectContext];
        
        if (i % 3 == 0)
            [phylo setUser:adminUser];
        else if (i % 3 == 1)
            [phylo setUser:user];
        else if (i % 3 == 2)
            [phylo setUser:nil];
        i++;
        
        [phylo setName:model.name];
        [phylo setScientific_name:model.species];
        [phylo setPhoto:photo];
        [phylo setArtist:@"Photographer"];
        [phylo setScale:model.creature_size];
        
        [phylo setCold: model.cold];
        [phylo setCool: model.cool];
        [phylo setWarm: model.warm];
        [phylo setHot: model.hot];
        
        [phylo setHabitat:model.habitat];
        [phylo setHabitat2:model.habitat2];
        [phylo setHabitat3:model.habitat3];
        [phylo setTerrains:[NSString stringWithFormat:@"%@, %@", model.habitat2, model.habitat3]];
        
       
        
        [phylo setDesc:@"..."];
        [phylo setEvolutionary:[NSString stringWithFormat:@"%@, %@, %@", model.kingdom, model.phylum, model.creature_class]];
        [phylo setKingdom:model.kingdom];
        [phylo setPhylum:model.phylum];
        [phylo setCreature_class:model.creature_class];
        [phylo setDiet:model.diet];
        if([model.diet isEqualToString:@"carnivore"]){
            [phylo setFoodChain:@"4"];
        }
        else if([model.diet isEqualToString:@"omnivore"]){
            [phylo setFoodChain:@"3"];
        }
        else if([model.diet isEqualToString:@"herbivore"]){
            [phylo setFoodChain:@"2"];
        }
        else if([model.diet isEqualToString:@"photosynthetic"]){
            [phylo setFoodChain:@"1"];
        }
        [phylo fixPoints];
        // set the image
        UIImage *selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", model.name, @".png"]];
        
        // Associate the photo object with the phylodex entry
        photo.image = selectedImage;
        
        // Create a thumbnail version of the image for the event object.
        CGSize size = selectedImage.size;
        CGFloat ratio = 0;
        if (size.width > size.height) {
            ratio = 65.0 / size.width;
        }
        else {
            ratio = 65.0 / size.height;
        }
        CGRect rect = CGRectMake(0.0, 0.0, ratio * size.width, ratio * size.height);
        
        UIGraphicsBeginImageContext(rect.size);
        [selectedImage drawInRect:rect];
        phylo.thumbnail = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }
	
	// Commit the change.
	NSError *error = nil;
	if (![_managedObjectContext save:&error]) {
		// Handle the error.
	}
    
}

// FOR DEVELOPMENT PURPOSES!!!
// source: http://stackoverflow.com/questions/4956905/core-data-database-is-empty-test
// checks if the core data store is empty
- (BOOL)coreDataHasEntriesForEntityName:(NSString *)entityName {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    [request setFetchLimit:1];
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!results) {
       // handle error
    }
    if ([results count] == 0) {
        return NO;
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Phylodex" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Phylodex.sqlite"];
    
    // FOR DEVELOPMENT PURPOSES: DELETES THE STORE
    // this is sometimes needed to flush out old stores, to remove conflicts, because sometimes
    // there is a compiler error when an old store exists
    // remember to re-comment the line and re-compile after deleting the store so its not
    // deleted everytime the program runs from being closed
//    [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - PXNetworkManager Key-value observer handler

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // if there is any ongoing network connections set the network activity indicator in UI
    if (context == &self->_networkOperationCountDummy) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = ([PXNetworkManager sharedInstance].networkOperationCount != 0);
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
