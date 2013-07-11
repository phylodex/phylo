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
@property (copy, nonatomic) NSMutableArray *selectedAnimals;
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
                                               scrollViewTexturedBackgroundColor] colorWithAlphaComponent:0.4];
        
        UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc]
                                      initWithTitle:@"Send Selected"
                                      style:UIBarButtonItemStyleBordered
                                      target:self
                                      action:@selector(share_button_clicked:)];
        self.navigationItem.rightBarButtonItem = btnCancel;
        self.collectionView.allowsMultipleSelection = YES;
        _selectedAnimals = [[NSMutableArray alloc] init];
    }
    return self;
}

- (IBAction)share_button_clicked:(id)sender
{

    
    if ([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init]; 
        if ( mailController != nil ) {
            mailController.mailComposeDelegate = self;
    
            [mailController setSubject:@"My Phylo Creatures"];
            
            NSMutableString *message_body_creatures = [[NSMutableString alloc] init];
            [message_body_creatures appendString:@"<html>"];
            for (PXDummyModel *phyloCreature in _selectedAnimals) {
                
                [message_body_creatures appendString:@"<b>"];
                [message_body_creatures appendString:(phyloCreature.species)];
                [message_body_creatures appendString:@":</b><i>"];
                [message_body_creatures appendString:(phyloCreature.name)];
                [message_body_creatures appendString:@"</i>, <br>"];
                UIImage *tempImg = phyloCreature.image;
                NSData *imageData = UIImageJPEGRepresentation(tempImg,0.9);
                NSString *strFileName = [NSString stringWithFormat:@"%@-picture.jpeg",phyloCreature.name];
                [mailController addAttachmentData:imageData mimeType:@"image/jpeg" fileName:strFileName];
                
            }
            [mailController setMessageBody:message_body_creatures isHTML:YES];
            
            mailController.modalPresentationStyle = UIModalPresentationPageSheet;
    
            [self presentViewController:mailController animated:YES completion:NULL];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Run Away" message:@"Fix it" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    /*
    NSLog(@"SHARING:");
    
     */
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Clicked an animal");
    // Determine the selected items by using the indexPath
    PXDummyModel *selectedAnimal = [lifeforms objectAtIndex:indexPath.row];
   // NSString *selectedName = selectedAnimal.name;
    // Add the selected item into the array
    [_selectedAnimals addObject:selectedAnimal];
//    [_selectedAnimals addObject:@"CAT"];
    NSLog(@"%d",[_selectedAnimals count]);
  //  NSLog(@"%@", selectedName);
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Deselected an animal");
    // Determine the selected items by using the indexPath
    PXDummyModel *deselectedAnimal = [lifeforms objectAtIndex:indexPath.row];
    [_selectedAnimals removeObject:deselectedAnimal];
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
