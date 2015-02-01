//
//  WheatherViewController.h
//  UW
//
//  Created by Gnrn on 30.01.15.
//  Copyright (c) 2015 Gnrn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Wheather.h"
@interface WheatherViewController : UIViewController <CLLocationManagerDelegate>
- (IBAction)getResult:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *resultField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progressIndicator;

@end
