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
    //[newCreature setValue:self.speciesType.text forKey:@"species"];
    [newCreature setValue:self.habitatType.text forKey:@"habitat"];
    
    parent.nameTextField.text = self.nameOfCreature.text;
    
    NSError *error;
    [context save:&error];
    self.displayLabel.text = @"Information is successfully updated!";
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backgroundTap:(id)sender{
    [self.nameOfCreature resignFirstResponder];
    [self.habitatType resignFirstResponder];
}

@end
