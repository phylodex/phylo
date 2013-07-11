//
//  PXShareCell.m
//  Phylodex
//
//  Created by ParkaPal on 2013-07-04.
//  Copyright (c) 2013 Phylosoft. All rights reserved.
//

#import "PXShareCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation PXShareCell

//called when cell made through code
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        //id for restore, sizing and cell colour info
        self.restorationIdentifier = @"cvCell";
        self.backgroundColor = [UIColor whiteColor];
        self.autoresizingMask = UIViewAutoresizingNone;
        
        //setup for highlight box when cell is selected
        CGFloat borderWidth = 5.0f;
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectZero];
        CGFloat nRed=255.0/255.0;
        CGFloat nGreen=214.0/255.0;
        CGFloat nBlue=99.0/255.0;
        UIColor *myColor=[[UIColor alloc]initWithRed:nRed green:nGreen blue:nBlue alpha:1];
        bgView.layer.borderColor = myColor.CGColor;
        bgView.layer.borderWidth = borderWidth;
        self.selectedBackgroundView = bgView;
    }
    return self;
}

// called for cells from xib?
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // id for restore, sizing and cell colour info
        self.restorationIdentifier = @"cvCell";
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingNone;
        
        // setup for highlight box when cell is selected
        CGFloat borderWidth = 3.0f;
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectZero];
        CGFloat nRed=255.0/255.0;
        CGFloat nGreen=214.0/255.0;
        CGFloat nBlue=99.0/255.0;
        UIColor *myColor=[[UIColor alloc]initWithRed:nRed green:nGreen blue:nBlue alpha:1];
        bgView.layer.borderColor = myColor.CGColor;
        bgView.layer.borderWidth = borderWidth;
        self.selectedBackgroundView = bgView;
        NSLog(@"Made with frame somehow"); // alert in log because this probably shouldn't be happening
        
    }
    return self;
}


//name label setter
- (void)setName:(NSString *)name
{
    if (![name isEqualToString:_name]) {
        _name = [name copy];
        _creatureName.text = _name;
    }
}


//this version for setting images directly
- (void)setImage:(UIImage *)image
{
    _image = [image copy];
    _creatureImage.image = _image;
}


//this version for setting images by paths
- (void) setImagepath:(NSString *)imagepath
{
    if (![imagepath isEqualToString:_imagepath]) {
        _imagepath = [imagepath copy];
        _creatureImage.image = [UIImage imageNamed:_imagepath];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
