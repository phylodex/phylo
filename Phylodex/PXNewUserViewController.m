//
//  PXNewUserViewController.m
//  Phylodex
//
//  Created by Steve King on 2013-07-27.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXNewUserViewController.h"

@interface PXNewUserViewController ()

@end

@implementation PXNewUserViewController

@synthesize delegate, userID, userNameTextField, fullNameTextField, passwordTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createUserButtonWasPressed:(id)sender
{
    // inform delegate that user was added
    [delegate newUserWasCreated:self];
}

@end
