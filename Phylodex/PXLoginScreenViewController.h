//
//  PXLoginScreenViewController.h
//  Phylodex
//
//  Created by Steve King on 2013-07-25.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXUserManager.h"
#import "PXUserSpaceViewController.h"
#import "PXManageUsersViewController.h"

@protocol PXLoginScreenViewControllerDelegate;

@interface PXLoginScreenViewController : UIViewController <PXUserSpaceViewControllerDelegate, PXManageUsersViewControllerDelegate> {
    IBOutlet UITextField *passwordTextField;
    IBOutlet UIButton *loginButton;
}

@property (nonatomic, retain) UIButton *loginButton;
@property (nonatomic, retain) UITextField *passwordTextField;
@property (nonatomic, retain) NSNumber *userID; // id of user trying to log in
@property (nonatomic, assign)id <PXLoginScreenViewControllerDelegate> delegate;

- (IBAction)loginButtonWasPressed:(id)sender;

//- (void)login;

@end

@protocol PXLoginScreenViewControllerDelegate

-(void)loginDidCancel;
//-(void)user:(NSString *)userID didAttemptLoginWithPassword:(NSString *)password;
//-(void)userDidLogin;

@end
