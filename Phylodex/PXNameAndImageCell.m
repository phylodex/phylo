//
//  PXNameAndColorCell.m
//  Cells
//
//  Created by ParkaPal on 2013-06-22.
//  Copyright (c) 2013 ParkaPal. All rights reserved.
//

#import "PXNameAndImageCell.h"

@implementation PXNameAndImageCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setName:(NSString *)name
{
    if (![name isEqualToString:_name]) {
        _name = [name copy];
        _nameValue.text = _name;
    }
}

- (void)setSpecies:(NSString *)species
{
    if (![species isEqualToString:_species]) {
        _species = [species copy];
        _speciesValue.text = _species;
    }
}

//this version for images directly
- (void)setImage:(UIImage *)image
{
    _image = [image copy];
    _imagepathValue.image = _image;
}

//this version for paths
 - (void)setImagepath:(NSString *)imagepath
{
    if (![imagepath isEqualToString:_imagepath]) {
        _imagepath = [imagepath copy];
        _imagepathValue.image = [UIImage imageNamed:_imagepath];
    }
}
- (void)willTransitionToState:(UITableViewCellStateMask)state {
    
    [super willTransitionToState:state];
    
    if (state == UITableViewCellStateDefaultMask) {
        
        NSLog(@"Default");
        // When the cell returns to normal (not editing)
        // Do something...
        _nameSpacer.constant = 20;
        _speciesSpacer.constant = 20;
        _imageSpacer.constant = 0;
        
    } else if ((state & UITableViewCellStateShowingEditControlMask) && (state & UITableViewCellStateShowingDeleteConfirmationMask)) {
        
        NSLog(@"Edit Control + Delete Button");
        // When the cell goes from Showing-the-Edit-Control (-) to Showing-the-Edit-Control (-) AND the Delete Button [Delete]
        // !!! It's important to have this BEFORE just showing the Edit Control because the edit control applies to both cases.!!!
        // Do something...
        NSLog(@"Need to indent the ");
        NSLog(@"%@", _nameValue.text);
        _imageSpacer.constant = -80;
        
    } else if (state & UITableViewCellStateShowingEditControlMask) {
        
        NSLog(@"Edit Control Only");
        // When the cell goes into edit mode and Shows-the-Edit-Control (-)
        // Do something...
        NSLog(@"Need to indent the ");
        NSLog(@"%@", _nameValue.text);
        _nameSpacer.constant = 40;
        _speciesSpacer.constant = 40;
        _imageSpacer.constant = 0;
    } else if (state == UITableViewCellStateShowingDeleteConfirmationMask) {
        
        NSLog(@"Swipe to Delete [Delete] button only");
        // When the user swipes a row to delete without using the edit button.
        // Do something...
    }
}
@end

