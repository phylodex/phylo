//
//  PXNameAndContentCell.m
//  Phylodex
//
//  Created by Daniel Hua on 2013-07-26.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXNameAndContentCell.h"

@implementation PXNameAndContentCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setName:(NSString *)name
{
    if (![name isEqualToString:_name]) {
        _name = [name copy];
        _nameLabel.text = _name;
        NSLog(@"hererererererererererer");
    }
}

- (void)setContent:(NSString *)content
{
    if (![content isEqualToString:_content]) {
        _content = [content copy];
        _contentLabel.text = _content;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end

