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
    
    float latitude;
    float lontitude;
    
}

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.manager = [[CLLocationManager alloc]init];
    self.geocoder = [[CLGeocoder alloc]init];
    if(IS_OS_8_OR_LATER){
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([self.manager respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                [self.manager requestAlwaysAuthorization];
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [self.manager requestWhenInUseAuthorization];
            }
        }
    }
    [self.manager startUpdatingLocation];
    [self.progressIndicator setHidden:YES];
}

- (IBAction)getResult:(id)sender
{
    self.resultField.text = @" ";
    self.manager.delegate = self;
    self.manager.desiredAccuracy = kCLLocationAccuracyKilometer;
    [self.progressIndicator setHidden:NO];
    [self.progressIndicator startAnimating];
     [self getCurrentWithLat:self->latitude andLon:self->lontitude];
}


#pragma mark CLLocationManagerDelegate Methods

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    self.resultField.text = [NSString stringWithFormat:@"Fail with Location manager error - %@",error];
    
}

-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *current = newLocation;
    if (current != nil) {
        [manager stopUpdatingLocation];
        latitude = current.coordinate.latitude;
        lontitude = current.coordinate.longitude;
    }
    [self.geocoder reverseGeocodeLocation:current completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error == nil && placemarks.count >0) {
            self.placemark = [placemarks lastObject];
        }else{
            self.resultField.text = [NSString stringWithFormat:@"Fail with error - %@",error];
        }
    }];
}

- (void)getCurrentWithLat : (float) latitude2 andLon : (float) lontitude2
{
    NSString *const BASE_URL_STRING = @"http://api.openweathermap.org/data/2.5/weather";
    NSString *weatherURLText = [NSString stringWithFormat:@"%@?lat=%f&lon=%f",
                                BASE_URL_STRING, latitude2, lontitude2];
    NSURL *weatherURL = [NSURL URLWithString:weatherURLText];
    NSURLRequest *weatherRequest = [NSURLRequest requestWithURL:weatherURL];
    [weatherRequest description];
    AFHTTPSessionManager *aFManager = [AFHTTPSessionManager manager];
    aFManager.requestSerializer = [AFJSONRequestSerializer serializer];
    [aFManager GET:[weatherURL absoluteString]
        parameters:nil
           success:^(NSURLSessionDataTask *task, id responseObject) {
               self.weatherServiceResponse = (NSDictionary *) responseObject;
               [self jsonDictioraryParse:_weatherServiceResponse];
               [self.progressIndicator setHidden:YES];
               [self.progressIndicator stopAnimating];
           }
           failure:^(NSURLSessionDataTask *task, NSError *error) {
               self.resultField.text = [NSString stringWithFormat:@"Fail with request error - %@",error];
               [self.progressIndicator stopAnimating];
               [self.progressIndicator setHidden:YES];
           }];
    
}

-(void) jsonDictioraryParse : (NSDictionary *) info
{
    NSArray *keys = [info allKeys];
    NSArray *values = [info allValues];
    NSMutableString *resultString = [[NSMutableString alloc] init];
    for (int i = 0; i<info.count; i++) {
        if ([[values[i] class] isSubclassOfClass: [NSString class]]) {
            [resultString appendFormat:@"%@ : %@\n",keys[i] ,values[i]];
        }else if ([[values[i] class] isSubclassOfClass: [NSNumber class]]){
            [resultString appendFormat:@"%@ : %@\n",keys[i] ,values[i]];
        }else if ([[values[i] class] isSubclassOfClass: [NSArray class]]){
            [resultString appendFormat:@"%@ : \n                 ",keys[i]];
            NSDictionary *d = [values[i] firstObject];
            for (id key in d.allKeys) {
                [resultString appendFormat:@"%@ : %@\n                 ",key,[d valueForKey:key]];
            }
            [resultString appendString:@"\n"];
        }else if ([[values[i] class] isSubclassOfClass: [NSDictionary class]]){
            [resultString appendFormat:@"%@ : \n                 ",keys[i]];
            NSDictionary *dickt = values[i];
            for (id key in dickt.allKeys) {
                [resultString appendFormat:@"%@ : %@\n                 ",key,[dickt valueForKey:key]];
            }
            [resultString appendString:@"\n"];
        }
    }
    self.resultField.text = resultString;
}

@end
