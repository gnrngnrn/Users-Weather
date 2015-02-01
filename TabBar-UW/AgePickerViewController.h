//
//  AgePickerViewController.h
//  UW
//
//  Created by Gnrn on 29.01.15.
//  Copyright (c) 2015 Gnrn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserEntity.h"
#import "DetailUserViewController.h"
@class DetailUserViewController;
@interface AgePickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *agePicker;
@property (strong, nonatomic) NSMutableArray *agesVariants;
@property (weak,nonatomic) DetailUserViewController *delegateCont;
////
- (IBAction)doneAction:(id)sender;
@end
