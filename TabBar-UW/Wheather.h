//
//  Wheather.h
//  UW
//
//  Created by Gnrn on 31.01.15.
//  Copyright (c) 2015 Gnrn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "WheatherViewController.h"

@class WheatherViewController;
@interface Wheather : NSObject
@property (strong,nonatomic) WheatherViewController *delegate;
////
@property (nonatomic) float lat;
@property (nonatomic) float lon;
////
- (void)getCurrent;
@end
