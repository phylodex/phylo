//
//  PXEditUserViewController.h
//  Phylodex
//
//  Created by Steve King on 2013-07-27.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PXEditUserViewController : UIViewController {
    IBOutlet UITextField *passwordTextField;
    IBOutlet UITextField *fullNameTextField;
    IBOutlet UITextField *userNameTextField;
    IBOutlet UIButton *revertButton;
}

@property (nonatomic, retain)NSString *userID;

@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *fullNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *revertButton;

- (IBAction)revertButtonWasPressed:(id)sender;

@end