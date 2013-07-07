//
//  PXHabitat.h
//  DetailView
//
//  Created by Artha on 13-6-22.
//  Copyright (c) 2013年 Artha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PXHabitat : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    UIPickerView *habitatItems;
    NSArray *habitatArray;
}

@property (nonatomic, retain) IBOutlet UIPickerView *habitatItems;
@property (nonatomic, retain) NSArray *habitatArray;
- (IBAction)Apply:(id)sender;

@end
