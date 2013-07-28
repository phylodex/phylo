//
//  PXLoginScreenViewController.m
//  Phylodex
//
//  Created by Steve King on 2013-07-25.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXLoginScreenViewController.h"

@interface PXLoginScreenViewController ()

@end

@implementation PXLoginScreenViewController

@synthesize passwordTextField, loginButton, userID, delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // obscure the input password text
        passwordTextField.secureTextEntry = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Cancel"
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

- (void)viewDidDisappear:(BOOL)animated
{
//    [delegate userDidLogin];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginButtonWasPressed:(id)sender
{
    NSString *password = passwordTextField.text;
//    [delegate user:userID didAttemptLoginWithPassword:password];
    [self didAttemptLoginWithPassword:password];
}

- (IBAction)cancel:(id)sender
{
    [delegate loginDidCancel];
}

-(void)didAttemptLoginWithPassword:(NSString *)password
{
    
    PXDummyUser *loginUser = nil;

    // check if the user password is correct, and log them in
    if ( [[PXUserManager sharedInstance] loginUserByUserID:userID withPassword:password] ) {
        // found the user, who is now the logged in user
        loginUser = [PXUserManager sharedInstance].currentUser;
        
        // push the view controller for the user
        // for normal user
        if ([loginUser.role isEqualToString:@"user"]) {
            PXUserSpaceViewController *userSpaceController = [[PXUserSpaceViewController alloc] initWithNibName:@"PXUserSpaceViewController" bundle:nil];
            userSpaceController.delegate = self;
            [self.navigationController pushViewController:userSpaceController animated:YES];
        }
        else if ([loginUser.role isEqualToString:@"admin"]) {
            // login in admin user
            PXManageUsersViewController *manageUsersController = [[PXManageUsersViewController alloc] init];
            manageUsersController.delegate = self;
            [self.navigationController pushViewController:manageUsersController animated:YES];
        }
    }
    else {
        passwordTextField.text = nil;
        // do nothing, the login password was incorrect
        // TO-DO: give some feedback to user of incorrect login credentials
//        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - PXUserSpaceViewControllerDelegate methods

- (void)userDidLogout:(UIViewController *)controller
{
    // log the user out
    [[PXUserManager sharedInstance] logout];
    [controller.navigationController popToRootViewControllerAnimated:YES];
}


@end
