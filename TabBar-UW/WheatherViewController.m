//
//  WheatherViewController.m
//  UW
//
//  Created by Gnrn on 30.01.15.
//  Copyright (c) 2015 Gnrn. All rights reserved.
//

#import "WheatherViewController.h"

@interface WheatherViewController ()

@end

@implementation WheatherViewController{
    CLLocationManager *manager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    NSString *latitude;
    NSString *lontitude;
    CGFloat *lat;
    CGFloat *lon;
    Wheather *wheather;
}
@synthesize resultField,progressIndicator;
- (void)viewDidLoad
{
    [super viewDidLoad];
    manager = [[CLLocationManager alloc]init];
    geocoder = [[CLGeocoder alloc]init];
    wheather = [[Wheather alloc] init];
    wheather.delegate = self;
    [self.progressIndicator setHidden:YES];
}
- (IBAction)getResult:(id)sender {
    manager.delegate = self;
    manager.desiredAccuracy = kCLLocationAccuracyKilometer;
    [manager startUpdatingLocation];
}
#pragma mark CLLocationManagerDelegate Methods
-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    self.resultField.text = [NSString stringWithFormat:@"Fail with error - %@",error];
    
}
-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    CLLocation *current = newLocation;
    if (current != nil) {
        latitude = [NSString stringWithFormat:@"%.2f",current.coordinate.latitude];
        lontitude = [NSString stringWithFormat:@"%.2f",current.coordinate.longitude];
        [manager stopUpdatingLocation];
        wheather.lat = [latitude floatValue];
        wheather.lon = [lontitude floatValue];
        [self.progressIndicator setHidden:NO];
        [self.progressIndicator startAnimating];
        [wheather getCurrent];
        
    }[geocoder reverseGeocodeLocation:current completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error == nil && placemarks.count >0) {
            placemark = [placemarks lastObject];
        }else{
            self.resultField.text = [NSString stringWithFormat:@"Fail with error - %@",error];
        }
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
