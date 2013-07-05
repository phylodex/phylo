//
//  PXShareViewController.m
//  Phylodex
//
//  Created by ParkaPal on 2013-07-04.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXShareViewController.h"
#import "PXShareCell.h"

@interface PXShareViewController ()
@property (copy, nonatomic) NSArray *sections;
@end

@implementation PXShareViewController

@synthesize lifeforms;

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        // Custom initialization
        self.title = @"Share";
        self.tabBarItem.image = [UIImage imageNamed:@"Share"];
        UINib *nib = [UINib nibWithNibName:@"PXShareCell" bundle:nil];
        [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"CONTENT"];
        self.view.backgroundColor = [UIColor blackColor];
        self.collectionView.backgroundColor = [[UIColor
                                               scrollViewTexturedBackgroundColor] colorWithAlphaComponent:0.3];
        
        UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc]
                                      initWithTitle:@"Send Selected"
                                      style:UIBarButtonItemStyleBordered
                                      target:self
                                      action:@selector(cancel_Clicked:)];
        self.navigationItem.rightBarButtonItem = btnCancel;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    lifeforms = [NSMutableArray array];
    PXDummyCollection *collection = [[PXDummyCollection alloc] init];
    for (PXDummyModel *model in collection.dummyModels) {
        [lifeforms addObject:model];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView
                                               *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return [lifeforms count];

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PXShareCell *cell = [self.collectionView
                            dequeueReusableCellWithReuseIdentifier:@"CONTENT"
                            forIndexPath:indexPath];
    
    // Configure the cell...
    PXDummyModel *lifeform = [lifeforms objectAtIndex:indexPath.row];
    cell.name = lifeform.name;
    cell.image = lifeform.image;
    return cell;

}
@end
