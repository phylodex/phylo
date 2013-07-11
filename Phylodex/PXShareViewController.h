//
//  PXShareViewController.h
//  Phylodex
//
//  Created by ParkaPal on 2013-07-04.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "PXDummyCollection.h"


@interface PXShareViewController : UICollectionViewController <MFMailComposeViewControllerDelegate>

@property (nonatomic, retain)NSMutableArray *lifeforms; // list of animals

@end
