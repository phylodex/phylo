//
//  PXType.h
//  DetailView
//
//  Created by Artha on 13-6-22.
//  Copyright (c) 2013年 Artha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PXType : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    UIPickerView *typeItems;
    NSArray *typeArray;
}

@property (nonatomic, retain) IBOutlet UIPickerView *typeItems;
@property (nonatomic, retain) NSArray *typeArray;
- (IBAction)Apply:(id)sender;




@end
