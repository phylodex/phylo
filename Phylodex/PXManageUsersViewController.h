//
//  PXManageUsersViewController.h
//  Phylodex
//
//  Created by Steve King on 2013-07-27.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXUserManager.h"
#import "PXNewUserViewController.h"
#import "PXEditUserViewController.h"

@protocol PXManageUsersViewControllerDelegate;

@interface PXManageUsersViewController : UITableViewController <PXNewUserViewControllerDelegate>

// array of users
@property (nonatomic, retain)NSMutableArray *users;
@property (nonatomic, assign)id <PXManageUsersViewControllerDelegate> delegate;

@end

@protocol PXManageUsersViewControllerDelegate

- (void)userDidLogout:(UIViewController *)controller;

@end