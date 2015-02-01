//
//  SingletonUsersArray.h
//  Users_Wheather
//
//  Created by Gnrn on 29.01.15.
//  Copyright (c) 2015 Gnrn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonUsersArray : NSObject{
    NSMutableArray *usersArray;
}
@property (nonatomic,strong) NSMutableArray *usersArray;

+(SingletonUsersArray *) sharedInstance;


@end
