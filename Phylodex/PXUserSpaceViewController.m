//
//  PXUserSpaceViewController.m
//  Phylodex
//
//  Created by Steve King on 2013-07-27.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXUserSpaceViewController.h"
#import "PXUserManager.h"

@interface PXUserSpaceViewController ()

@property (nonatomic, retain)PXDummyUser *user;

@end

@implementation PXUserSpaceViewController

@synthesize delegate, userID, user, userNameTextField, fullNameTextField, revertButton, passwordTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // return the user
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set the logout button on navigation bar
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Log Out"
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(logout:)];
    self.navigationItem.leftBarButtonItem = logoutButton;
    
    // set the save button, when pressed saves any changes to the database for user
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Save"
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    // populate the text fields with the users data
    [self refreshUserData];
}

- (void)refreshUserData
{
    // get the latest user info from database
    user = [PXUserManager sharedInstance].currentUser;
    
    passwordTextField.text = user.password;
    userNameTextField.text = user.userName;
    fullNameTextField.text = user.fullName;
    self.title = user.userName;
}

- (void)logout:(id)sender
{
    [delegate userDidLogout:self];
}

- (void)save:(id)sender
{
    NSString *newPassword = passwordTextField.text;
    NSString *newUserName = userNameTextField.text;
    NSString *newFullName = fullNameTextField.text;
    
    PXUserManager *userManager = [PXUserManager sharedInstance];
    
    [userManager updateUserWithUserID:userID withPassword:newPassword withUserName:newUserName withFullName:newFullName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)revertButtonWasPressed:(id)sender
{
    [self refreshUserData];
}

@end

