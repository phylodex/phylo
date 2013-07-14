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


// run when layout is created
- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {// Custom initialization
        //info for tab bar + nav bar
        self.title = @"Share";
        self.tabBarItem.image = [UIImage imageNamed:@"Share"];
        //set what kind of cell to use and what flag to look for when adding one
        UINib *nib = [UINib nibWithNibName:@"PXShareCell" bundle:nil];
        [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"SHARECELL"];
        //set some UI visuals
        self.view.backgroundColor = [UIColor blackColor];
        self.collectionView.backgroundColor = [[UIColor
                                               scrollViewTexturedBackgroundColor] colorWithAlphaComponent:0.4];
        //add the send button to the nav bar
        UIBarButtonItem *btnSend = [[UIBarButtonItem alloc]
                                      initWithTitle:@"Send Selected"
                                      style:UIBarButtonItemStyleBordered
                                      target:self
                                      action:@selector(share_button_clicked:)];
        self.navigationItem.rightBarButtonItem = btnSend;
        //let users pick multiple
        self.collectionView.allowsMultipleSelection = YES;
        //start the array that will store selections
        _selectedAnimals = [[NSMutableArray alloc] init];
    }
    return self;
}

// run when the send button is clicked
- (IBAction)share_button_clicked:(id)sender
{
    //make sure you can send
    if ([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
        //if init was successful
        if ( mailController != nil ) {
            //set self as the delegate
            mailController.mailComposeDelegate = self;
            //initial subject
            [mailController setSubject:@"My Phylo Creatures"];
            //setup content of the email to preload
            NSMutableString *message_body_creatures = [[NSMutableString alloc] init];
            //fill string with data from db
            [message_body_creatures appendString:@"<html>"];
            for (PXDummyModel *phyloCreature in _selectedAnimals) {
                [message_body_creatures appendString:@"<b>"];
                [message_body_creatures appendString:(phyloCreature.species)];
                [message_body_creatures appendString:@":</b><i>"];
                [message_body_creatures appendString:(phyloCreature.name)];
                [message_body_creatures appendString:@"</i>, <br>"];
                //get each image and add as attachment
                UIImage *tempImg = phyloCreature.image;
                NSData *imageData = UIImageJPEGRepresentation(tempImg,0.9);
                NSString *strFileName = [NSString stringWithFormat:@"%@-picture.jpeg",phyloCreature.name];
                [mailController addAttachmentData:imageData mimeType:@"image/jpeg" fileName:strFileName];
            }
            [mailController setMessageBody:message_body_creatures isHTML:YES];
            
            //set how to present and bring it up
            mailController.modalPresentationStyle = UIModalPresentationPageSheet;
            [self presentViewController:mailController animated:YES completion:NULL];
        }
    }
    //MFMailComposeViewController can't send for some reason (permissions?
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Can't Send" message:@"Please check your permissions" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

//on dismissal of mail popup
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //respond based on exit status
    switch (result){
        case MFMailComposeResultCancelled:
            NSLog(@"Cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Saved");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Failed");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Sent");
            break;
        default:
            NSLog(@"default");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Determine the selected items by using the indexPath
    PXDummyModel *selectedAnimal = [lifeforms objectAtIndex:indexPath.row];
    // Add the selected item into the array
    [_selectedAnimals addObject:selectedAnimal];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
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
                            dequeueReusableCellWithReuseIdentifier:@"SHARECELL"
                            forIndexPath:indexPath];
    
    // Configure the cell...
    PXDummyModel *lifeform = [lifeforms objectAtIndex:indexPath.row];
    cell.name = lifeform.name;
    cell.image = lifeform.image;
    return cell;

}
@end
