//
//  simpleTableCell.m
//  Phylodex
//
//  Created by Yujie Zeng on 7/5/13.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "SimpleTableCell.h"

@implementation SimpleTableCell

@synthesize attributeLabel = _attributeLabel;
@synthesize valueLabel = _valueLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
