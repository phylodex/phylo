//
//  PXShareViewController.h
//  Phylodex
//
//  Description: Handles the sharing of user images by email
//
//  Created by ParkaPal on 2013-07-04.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "PXDummyCollection.h"
#import "Phylodex.h"
#import "Photo.h"


@interface PXShareViewController : UICollectionViewController <MFMailComposeViewControllerDelegate>
{
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain)NSMutableArray *lifeforms; // list of animals

@end
