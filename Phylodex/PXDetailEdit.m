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
@synthesize nameOfCreature, habitatType/*, artistInfo*/;
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
    
    [[self nameOfCreature]setDelegate:self];
    //  [[self speciesType]setDelegate:self];
    [[self habitatType]setDelegate:self];
    
    PXAppDelegate *phylo = [[UIApplication sharedApplication]delegate];
    context = [phylo managedObjectContext];

    
    // load the previous value to avoid no info typed
    nameOfCreature.text = [parent.valueArray objectAtIndex:0];
    habitatType.text = [parent.valueArray objectAtIndex:2];
//    artistInfo.text = [parent.valueArray objectAtIndex:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Phylodex" inManagedObjectContext:context];
    NSManagedObject *newCreature = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];

    [newCreature setValue:self.nameOfCreature.text forKey:@"name"];
    [newCreature setValue:self.habitatType.text forKey:@"habitat"];

//    [newCreature setValue:self.artistInfo.text forKey:@"artist"];
    
//    parent.valueArray = [NSArray arrayWithObjects:self.nameOfCreature.text, @"", self.habitatType.text/*, self.artistInfo.text*/, @"", nil];    // for valueArray in PXDetailViewController, cache
    parent.phyloELement.name = self.nameOfCreature.text;
    parent.phyloELement.habitat = self.habitatType.text;
//    parent.phyloElement.artist = self.artistInfo.text;
    
    NSError *error;
    [context save:&error];
    self.displayLabel.text = @"Info is updated!";
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backgroundTap:(id)sender{
    [nameOfCreature resignFirstResponder];
    [habitatType resignFirstResponder];
//    [artistInfo resignFirstResponder];
}

@end
