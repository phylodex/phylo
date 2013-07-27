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
//@synthesize nameText;
//@synthesize creditText;
//@synthesize nameLabel;
//@synthesize creditLabel;
@synthesize resultDictionary;
@synthesize table;
@synthesize scroller;

static NSString *CellTableIdentifier = @"PXNameAndContentCell";

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
//    nameLabel.text = nameText;
//    creditLabel.text = creditText;
    imageView.image = image; // = [[UIImageView alloc] initWithImage:image];
    
    scroller = [[UIScrollView alloc]init];
    table = [[UITableView alloc]init];
    UINib *nib = [UINib nibWithNibName:@"PXNameAndContentCell" bundle:nil];
    table.rowHeight = 120;
    [table registerNib:nib forCellReuseIdentifier: CellTableIdentifier];
    [scroller setScrollEnabled:YES];
    scroller.backgroundColor = [UIColor whiteColor];
    table.delegate = self;
    table.dataSource = self;
    scroller.delegate = self;
    [scroller addSubview:table];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PXNameAndContentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PXNameAndContentCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    if (indexPath.row == 0) {
        cell.nameLabel.text = @"Credit: ";
        cell.contentLabel.text = [resultDictionary objectForKey:@"CopyrightsHolder"];
    }
    if (indexPath.row == 1) {
        cell.nameLabel.text = @"Name: ";
        cell.contentLabel.text = [resultDictionary objectForKey:@"Name"];
    }
    if (indexPath.row == 2) {
        cell.nameLabel.text = @"Latin Name: ";
        cell.contentLabel.text = [resultDictionary objectForKey:@"Latin Name"];
    }
    if (indexPath.row == 3) {
        cell.nameLabel.text = @"Evolutionary Tree: ";
        cell.contentLabel.text = [resultDictionary objectForKey:@"Kingdom"];
    }
    if (indexPath.row == 4) {
        cell.nameLabel.text = @"Habitat: ";
        cell.contentLabel.text = [resultDictionary objectForKey:@"Habitat"];
    }
    
//        cell.textLabel.adjustsFontSizeToFitWidth = YES;
//        cell.textLabel.minimumScaleFactor = 0.6;
    
    return cell;
}

@end
