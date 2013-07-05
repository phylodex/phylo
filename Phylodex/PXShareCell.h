//
//  PXShareCell.h
//  Phylodex
//
//  Created by ParkaPal on 2013-07-04.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PXShareCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *label;
@property (copy, nonatomic) NSString *text;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *imagepath;
@property (copy, nonatomic) UIImage *image;

@property (weak, nonatomic) IBOutlet UILabel *creatureName;
@property (weak, nonatomic) IBOutlet UIImageView *creatureImage;

//+ (CGSize)sizeForContentString:(NSString *)s;
@end
