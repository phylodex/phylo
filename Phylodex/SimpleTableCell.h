//
//  simpleTableCell.h
//  Phylodex
//
//  Created by Yujie Zeng on 7/5/13.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *attributeLabel;
@property (nonatomic, weak) IBOutlet UILabel *valueLabel;

@end
