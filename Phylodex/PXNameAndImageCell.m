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

@end

