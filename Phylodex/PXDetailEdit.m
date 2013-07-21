//
//  PXDetailEdit.m
//  Phylodex
//
//  Created by Artha on 13-7-10.
//  Copyright (c) 2013年 Phylosoft. All rights reserved.
//

#import "PXDetailEdit.h"
#import "PXAppDelegate.h"


@interface PXDetailEdit (){
    NSManagedObjectContext *context;
}

@end

@implementation PXDetailEdit
@synthesize parent;
@synthesize nameOfCreature, habitatType, artistInfo;

@synthesize saveButton;

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
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    saveButton.enabled = YES;
    self.navigationItem.rightBarButtonItem = saveButton;
    
    
    [[self nameOfCreature]setDelegate:self];
    //  [[self speciesType]setDelegate:self];
    [[self habitatType]setDelegate:self];
    
    PXAppDelegate *phylo = [[UIApplication sharedApplication]delegate];
    context = [phylo managedObjectContext];
    
    
    // load the previous value to avoid no info typed
    nameOfCreature.text = [parent.valueArray objectAtIndex:0];
    artistInfo.text = [parent.valueArray objectAtIndex:3];
    habitatType.text = [parent.valueArray objectAtIndex:2];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)save {
    /*
     
     // No add function for now because core data is not complemented
     // Below is inserting new item function
     
     NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Phylodex" inManagedObjectContext:context];
     NSManagedObject *newCreature = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
     */
    
    
    //update the current data
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Phylodex" inManagedObjectContext:context];
    [request setEntity:entity];
    
    NSError *errorFetch = nil;
    NSArray *array = [context executeFetchRequest:request error:&errorFetch];
    NSLog(@"%d", array.count);
    for(Phylodex *newCreature in array){
        if(newCreature.name==[parent.valueArray objectAtIndex:0]){
            [newCreature setValue:self.nameOfCreature.text forKey:@"name"];
            [newCreature setValue:self.habitatType.text forKey:@"habitat"];
            [newCreature setValue:self.artistInfo.text forKey:@"artist"];
        }
        
    }
    
    parent.valueArray = [NSArray arrayWithObjects:self.nameOfCreature.text, @"Recent", self.habitatType.text, self.artistInfo.text, @"", nil];    // for valueArray in PXDetailViewController, cache
    
    NSLog(@"valueArray = %@", parent.valueArray);
    
    NSError *error;
    [context save:&error];
    self.displayLabel.text = @"Info is updated!";
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backgroundTap:(id)sender{
    [nameOfCreature resignFirstResponder];
    [habitatType resignFirstResponder];
    [artistInfo resignFirstResponder];
}

@end
