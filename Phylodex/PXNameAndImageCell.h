//
//  PXNameAndColorCell.h
//  Cells
//
//  Description: Custom cell for a phylodex entry
//
//  Created by ParkaPal on 2013-06-22.
//  Copyright (c) 2013 ParkaPal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PXNameAndImageCell : UITableViewCell

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *species;
@property (copy, nonatomic) NSString *imagepath;
@property (copy, nonatomic) UIImage *image;

@property (strong, nonatomic) IBOutlet UILabel *nameValue;
@property (strong, nonatomic) IBOutlet UILabel *speciesValue;
@property (strong, nonatomic) IBOutlet UIImageView *imagepathValue;

@end
