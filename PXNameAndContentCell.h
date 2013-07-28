//
//  PXNameAndContentCell.h
//  Phylodex
//
//  Created by Daniel Hua on 2013-07-26.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PXNameAndContentCell : UITableViewCell



@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *content;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *contentLabel;

@end
