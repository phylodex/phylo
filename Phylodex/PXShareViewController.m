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

@synthesize lifeforms, managedObjectContext;


- (void)viewWillAppear:(BOOL)animated
{
    //reset stored data
    lifeforms = [NSMutableArray array];
    [lifeforms removeAllObjects];
    [_selectedAnimals removeAllObjects];
    // Fetch existing phylodex entries.
    // Create a fetch request, add a sort descriptor, then execute the fetch.
    id delegate = [[UIApplication sharedApplication] delegate];
    managedObjectContext = [[NSManagedObjectContext alloc] init];
    self.managedObjectContext = [delegate managedObjectContext];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Phylodex" inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	
	// Order the entries by name
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	
	// Execute the fetch -- create a mutable copy of the result.
	NSError *error = nil;
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	if (mutableFetchResults == nil) {
		// Handle the error.
	}
	[self setLifeforms:mutableFetchResults];
    //draw collection view with fresh data from model
    [self.collectionView reloadData];
    
}

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
            [mailController setMessageBody:@"flower" isHTML:NO];
            //set self as the delegate
            mailController.mailComposeDelegate = self;
            //initial subject
            [mailController setSubject:@"My Phylo Creatures"];
            //setup content of the email to preload
            
            
            //setup content of the email to preload
            NSMutableString *shareHtmlBody = [[NSMutableString alloc] init];
            [shareHtmlBody setString:@""];
            [shareHtmlBody appendString:@"<html>     <head>     <link rel=\"stylesheet\" type=\"text/css\" media=\"print\" href=\"http://phylogame.org/wp-content/themes/phylomon-theme/print.css\">     <link rel=\"stylesheet\" type=\"text/css\" href=\"http://phylogame.org/wp-content/themes/phylomon-theme/style.css\">     </head>     <body>     <div class=\"card-container\">"];
            
            for (Phylodex *phyloCreature in _selectedAnimals) {
                
                UIImage *tempImg = phyloCreature.photo.image;
                NSData *imageData = UIImageJPEGRepresentation(tempImg,0.9);
                NSString *strFileName = [NSString stringWithFormat:@"%@-picture.jpeg",phyloCreature.name];
                [mailController addAttachmentData:imageData mimeType:@"image/jpeg" fileName:strFileName];
                
                [shareHtmlBody appendString:@" <div class=\"card count \" id=\""]; //card outside
                [shareHtmlBody appendString:(phyloCreature.name)]; //card id
                [shareHtmlBody appendString:@"\">        <img src=\"http://phylogame.org/wp-content/themes/phylomon-theme/img/generated-card-images/bg-F4F4CE-forest-forest-forest-1.png\" class=\"card-background\" alt=\"card-name-15888\"><h2 class=\"card-name  smaller-12 \" id=\"card-name-15888\">"]; //for now every card gets a forest background since we cant generate new ones
                [shareHtmlBody appendString:(phyloCreature.name)]; //card title
                
                [shareHtmlBody appendString:@"</h2> <span class=\"latin-name\">" ];
                [shareHtmlBody appendString:(phyloCreature.scientific_name)]; //latin name if it exists
                [shareHtmlBody appendString:@"</span>  <div class=\"num-values\"> <img src=\"http://phylogame.org/wp-content/themes/phylomon-theme/img/num/"];
                [shareHtmlBody appendString:phyloCreature.creature_size];
                [shareHtmlBody appendString:@".png\" alt=\"" ];
                [shareHtmlBody appendString:phyloCreature.creature_size ];
                [shareHtmlBody appendString:@"\"> <img src=\"http://phylogame.org/wp-content/themes/phylomon-theme/img/num/" ];
                [shareHtmlBody appendString:phyloCreature.diet ];
                [shareHtmlBody appendString:phyloCreature.heirarchy];
                [shareHtmlBody appendString:@".png\" alt=\"" ];
                [shareHtmlBody appendString:phyloCreature.diet ];
                [shareHtmlBody appendString:phyloCreature.heirarchy];
                [shareHtmlBody appendString:@"\">  </div>   <div class=\"card-image\">  <!-- GRAPHIC -->  <div class=\"graphic\"><img src=\""];
                
                
                
                [shareHtmlBody appendString:(strFileName)]; //for image path
                [shareHtmlBody appendString:@"\"></div> <div class=\"photo empty\">        <strong>Sorry, there is no photo available.  If you have one, please submit <a href=\"http://www.flickr.com/groups/1293102@N24/\">here</a>.</strong>   </div>  </div>" ];
                
                //Kingdom+Phylum+Class
                [shareHtmlBody appendString:@"<div class=\"card-classification\">  <a href=\"http://phylogame.org/classification/"];
                [shareHtmlBody appendString:phyloCreature.kingdom];
                [shareHtmlBody appendString:@"/\" rel=\"tag\">" ];
                [shareHtmlBody appendString:phyloCreature.kingdom];
                [shareHtmlBody appendString:@"</a>,<a href=\"http://phylogame.org/classification/"];
                 [shareHtmlBody appendString:phyloCreature.phylum];
                 [shareHtmlBody appendString:@"/\" rel=\"tag\">"];
                 [shareHtmlBody appendString:phyloCreature.phylum];
                 [shareHtmlBody appendString:@"</a>,<a href=\"http://phylogame.org/classification/"];
                 [shareHtmlBody appendString:phyloCreature.creature_class];
                 [shareHtmlBody appendString:@"/\" rel=\"tag\">"];
                 [shareHtmlBody appendString:phyloCreature.creature_class];
                 [shareHtmlBody appendString:@"</a>  </div> <div class=\"creative-commons\">  <a href=\"http://creativecommons.org/licenses/by-nc-nd/2.0/deed.en_CA\" target=\"_blank\"><img src=\"http://phylogame.org/wp-content/themes/phylomon-theme/img/creative-commons.png\" alt=\"Creative Commons Attribution-Noncommercial-No Derivatives Works 2.0\"></a>  </div>"];
                
                //everything is flying squirrel stats on the test
                [shareHtmlBody appendString:@"<div class=\"card-text\">        <p style=\"text-align: right;\"><strong>"];
                [shareHtmlBody appendString:phyloCreature.points];
                //[shareHtmlBody appendString:[NSString stringWithFormat:@"%d",phyloCreature.points]];
                [shareHtmlBody appendString:@" POINTS</strong></p><br> </div>"];
                
                [shareHtmlBody appendString:@" <div class=\"card-temperature\"> " ];
                if ([phyloCreature.cold isEqualToNumber:[NSNumber numberWithInt:1]]){
                    [shareHtmlBody appendString:@"Cold, "];
                }
                if ([phyloCreature.cool isEqualToNumber:[NSNumber numberWithInt:1]]){
                    [shareHtmlBody appendString:@"Cool, "];
                }
                if ([phyloCreature.warm isEqualToNumber:[NSNumber numberWithInt:1]]){
                    [shareHtmlBody appendString:@"Warm, "];
                }
                if ([phyloCreature.hot isEqualToNumber:[NSNumber numberWithInt:1]]){
                    [shareHtmlBody appendString:@"Hot "];
                }
                 [shareHtmlBody appendString:@"</div> <div class=\"card-credit\"> <div class=\"graphic\"> <!-- GRAPHIC -->  <span>Image by <em>"];
                [shareHtmlBody appendString:@"Some Photographer"];
                [shareHtmlBody appendString:@"</em></span>         </div>        </div>    	</div>    	</div>        </div>"];
                
            }
            [shareHtmlBody appendString:@"</div></body></html>"];
            
            /*
            NSMutableString *message_body_creatures = [[NSMutableString alloc] init];
            [message_body_creatures setString:@""];
            //fill string with data from db
            [message_body_creatures appendString:@"<html>"];
            for (Phylodex *phyloCreature in _selectedAnimals) {
                [message_body_creatures appendString:@"<b>"];
                [message_body_creatures appendString:(@"Species")];
                [message_body_creatures appendString:@":</b><i>"];
                [message_body_creatures appendString:(phyloCreature.name)];
                [message_body_creatures appendString:@"</i>, <br>"];
                
                [message_body_creatures appendString:@"<b>"];
                [message_body_creatures appendString:(@"Scientific Name")];
                [message_body_creatures appendString:@":</b><i>"];
                [message_body_creatures appendString:(phyloCreature.scientific_name)];
                [message_body_creatures appendString:@"</i>, <br>"];
                
                [message_body_creatures appendString:@"<b>"];
                [message_body_creatures appendString:(@"Classification")];
                [message_body_creatures appendString:@":</b><i>"];
                [message_body_creatures appendString:(phyloCreature.kingdom)];
                [message_body_creatures appendString:@","];
                [message_body_creatures appendString:(phyloCreature.phylum)];
                [message_body_creatures appendString:@","];
                [message_body_creatures appendString:(phyloCreature.creature_class)];
                [message_body_creatures appendString:@"</i> <br>"];
                
                [message_body_creatures appendString:@"<b>"];
                [message_body_creatures appendString:(@"Size")];
                [message_body_creatures appendString:@":</b><i>"];
                [message_body_creatures appendString:(phyloCreature.creature_size)];
                [message_body_creatures appendString:@"</i>, <br>"];
                
                [message_body_creatures appendString:@"<b>"];
                [message_body_creatures appendString:(@"Diet")];
                [message_body_creatures appendString:@":</b><i>"];
                [message_body_creatures appendString:(phyloCreature.diet)];
                [message_body_creatures appendString:(phyloCreature.heirarchy)];
                [message_body_creatures appendString:@"</i>, <br><br>"];
                
                
                
                //
                
                //get each image and add as attachment
                //Photo *animalPic = phyloCreature.photo;
                //UIImage *tempImg = animalPic.image;
                UIImage *tempImg = phyloCreature.thumbnail;
                NSData *imageData = UIImageJPEGRepresentation(tempImg,0.9);
                NSString *strFileName = [NSString stringWithFormat:@"%@-picture.jpeg",phyloCreature.name];
                [mailController addAttachmentData:imageData mimeType:@"image/jpeg" fileName:strFileName];
            }
             */
            [mailController setMessageBody:shareHtmlBody isHTML:YES];
            
            //set how to present and bring it up
            mailController.modalPresentationStyle = UIModalPresentationPageSheet;
            [self presentViewController:mailController animated:YES completion:NULL];
        }
    }
    //if MFMailComposeViewController can't send for some reason (permissions?
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
    Phylodex *lifeform = [lifeforms objectAtIndex:indexPath.row];
    cell.name = lifeform.name;
    //Photo *tempPic = lifeform.photo;
    //cell.image = tempPic.image;
    cell.image = lifeform.thumbnail;
    return cell;

}
@end
