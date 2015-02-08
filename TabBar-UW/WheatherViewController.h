//
//  WheatherViewController.h
//  UW
//
//  Created by Gnrn on 30.01.15.
//  Copyright (c) 2015 Gnrn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AFNetworking.h"

@interface WheatherViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *resultField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progressIndicator;
@property (strong,nonatomic) CLLocationManager *manager;
@property (strong,nonatomic) CLGeocoder *geocoder;
@property (strong,nonatomic) CLPlacemark *placemark;
@property (strong,nonatomic) NSDictionary *weatherServiceResponse;

- (IBAction)getResult:(id)sender;

@end
