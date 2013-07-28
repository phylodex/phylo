//
//  PXType.m
//  DetailView
//
//  Created by Artha on 13-6-22.
//  Copyright (c) 2013年 Artha. All rights reserved.
//

#import "PXType.h"

@interface PXType ()

@end

@implementation PXType

@synthesize typeItems;
@synthesize typeArray;

-(IBAction)Apply:(id)sender{
    NSInteger row = [typeItems selectedRowInComponent:0];
    NSString *choice = [typeArray objectAtIndex:row];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"The result has been changed" message:choice delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}


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
    NSArray *x = [[NSArray alloc]initWithObjects:@"Reptile", @"Bird", @"Mammal", @"Amphibian", "Fish", nil];
    self.typeArray = x;
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [typeArray count];
}

-(NSString *)PickerView: (UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [typeArray objectAtIndex:row];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
