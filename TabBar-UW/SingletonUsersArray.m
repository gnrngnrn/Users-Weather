//
//  SingletonUsersArray.m
//  Users_Wheather
//
//  Created by Gnrn on 29.01.15.
//  Copyright (c) 2015 Gnrn. All rights reserved.
//

#import "SingletonUsersArray.h"

@implementation SingletonUsersArray
@synthesize usersArray;

static SingletonUsersArray *singletonUsersArray = nil;
+(SingletonUsersArray *) sharedInstance{
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        singletonUsersArray = [[SingletonUsersArray alloc] init];
        singletonUsersArray.usersArray = [[NSMutableArray alloc] init];
    });
    
    return singletonUsersArray;
}
@end
