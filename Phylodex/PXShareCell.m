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

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        
        NSLog(@"MADE IT CODE");
        self.restorationIdentifier = @"cvCell";
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingNone;
        
        CGFloat borderWidth = 3.0f;
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectZero];
        CGFloat nRed=255.0/255.0;
        CGFloat nGreen=214.0/255.0;
        CGFloat nBlue=99.0/255.0;
        UIColor *myColor=[[UIColor alloc]initWithRed:nRed green:nGreen blue:nBlue alpha:1];
        bgView.layer.borderColor = myColor.CGColor;
        bgView.layer.borderWidth = borderWidth;
        self.selectedBackgroundView = bgView;
        
        // change to our custom selected background view
   //     CustomCellBackground *backgroundView = [[CustomCellBackground alloc] initWithFrame:CGRectZero];
     //   self.selectedBackgroundView = backgroundView;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       /*
         self.label = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        self.label.opaque = NO;
        self.label.backgroundColor = [UIColor colorWithRed:0.6
                                                     green:0.2
                                                      blue:0.2
                                                     alpha:1.0];
        self.label.textColor = [UIColor whiteColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        //self.label.font = [[self class] defaultFont];
        [self.contentView addSubview:self.label];
        */
        NSLog(@"MADE IT");
        
    }
    return self;
}

+ (UIFont *)defaultFont {
    return [UIFont boldSystemFontOfSize:24];
}

+ (CGSize)sizeForContentString:(NSString *)s {
    CGSize textSize = [s sizeWithFont:[self defaultFont]
                    constrainedToSize:CGSizeMake(300, 1000)
                        lineBreakMode:NSLineBreakByCharWrapping];
    return textSize;
}

- (NSString *)text {
    return self.label.text;
}
- (void)setText:(NSString *)text {
    self.label.text = text;
    CGRect newLabelFrame = self.label.frame;
    CGRect newContentFrame = self.contentView.frame;
    CGSize textSize = [[self class] sizeForContentString:text];
    newLabelFrame.size = textSize;
    newContentFrame.size = textSize;
    self.label.frame = newLabelFrame;
    self.contentView.frame = newContentFrame;
}

- (void)setName:(NSString *)name
{
    if (![name isEqualToString:_name]) {
        _name = [name copy];
        _creatureName.text = _name;
    }
}


//this version for images directly
- (void)setImage:(UIImage *)image
{
    _image = [image copy];
    _creatureImage.image = _image;
}

/*
//this version for paths
- (void)setImagepath:(NSString *)imagepath
{
    if (![imagepath isEqualToString:_imagepath]) {
        _imagepath = [imagepath copy];
        _imagepathValue.image = [UIImage imageNamed:_imagepath];
    }
}
*/

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
