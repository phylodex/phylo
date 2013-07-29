//
//  PXNewUserViewController.h
//  Phylodex
//
//  Created by Steve King on 2013-07-27.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PXNewUserViewControllerDelegate;

@interface PXNewUserViewController : UIViewController {
    IBOutlet UITextField *passwordTextField;
    IBOutlet UITextField *fullNameTextField;
    IBOutlet UITextField *userNameTextField;
    IBOutlet UIButton *createButton;
}

@property (nonatomic, assign)id <PXNewUserViewControllerDelegate> delegate;
@property (nonatomic, retain)NSNumber *userID;

@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *fullNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
//@property (strong, nonatomic) IBOutlet UIButton *revertButton;

- (IBAction)createUserButtonWasPressed:(id)sender;

@end

@protocol PXNewUserViewControllerDelegate

- (void)cancel:(UIViewController *)controller;
- (void)newUserWasCreated:(UIViewController *)controller;

@end