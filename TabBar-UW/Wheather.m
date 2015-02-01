//
//  Wheather.m
//  UW
//
//  Created by Gnrn on 31.01.15.
//  Copyright (c) 2015 Gnrn. All rights reserved.
//

#import "Wheather.h"

@implementation Wheather{
    NSDictionary *weatherServiceResponse;
}
@synthesize delegate;
- (id)init
{
    self = [super init];
    
    weatherServiceResponse = @{};
    
    return self;
}

- (void)getCurrent
{
    NSString *const BASE_URL_STRING = @"http://api.openweathermap.org/data/2.5/weather";
    NSString *weatherURLText = [NSString stringWithFormat:@"%@?lat=%f&lon=%f",
                                BASE_URL_STRING, _lat, _lon];
    NSURL *weatherURL = [NSURL URLWithString:weatherURLText];
    NSURLRequest *weatherRequest = [NSURLRequest requestWithURL:weatherURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:[weatherURL absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             weatherServiceResponse = (NSDictionary *) responseObject;
             NSMutableString *res =[NSMutableString stringWithFormat:@"%@",responseObject];
             [res replaceOccurrencesOfString:@"(" withString:@"" options:NULL range:NSMakeRange(0, [res length])];
             [res replaceOccurrencesOfString:@";" withString:@"" options:NULL range:NSMakeRange(0, [res length])];
             [res replaceOccurrencesOfString:@")" withString:@"" options:NULL range:NSMakeRange(0, [res length])];
             [res deleteCharactersInRange:NSMakeRange(0, 2)];
              [res deleteCharactersInRange:NSMakeRange((res.length-1), 1)];
             self.delegate.resultField.text = res;
             }     
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             self.delegate.resultField.text = [NSString stringWithFormat:@"Fail with error - %@",error];
         }];
    
    [self.delegate.progressIndicator stopAnimating];
    [self.delegate.progressIndicator setHidden:YES];
}


@end
