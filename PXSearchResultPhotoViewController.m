//
//  PXSearchResultPhotoViewController.m
//  Phylodex
//
//  Created by Steve King on 2013-06-23.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXSearchResultPhotoViewController.h"

@interface PXSearchResultPhotoViewController ()

@end

@implementation PXSearchResultPhotoViewController

@synthesize image;
@synthesize imageView;
@synthesize nameText;
@synthesize creditText;
@synthesize nameLabel;
@synthesize creditLabel;

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
    nameLabel.text = nameText;
    creditLabel.text = creditText;
    imageView.image = image; // = [[UIImageView alloc] initWithImage:image];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
