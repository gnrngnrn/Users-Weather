//
//  UsersController.h
//  TabBar-UW
//
//  Created by Gnrn on 03.02.15.
//  Copyright (c) 2015 Gnrn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserEntity.h"

@interface UsersController : NSObject

@property (nonatomic,strong) NSMutableArray *usersArray;

-(void) saveToPlist;
-(void) sortArrayOfUsers;
-(void) loadArrayOfUsers;
-(void) addNewUserEntity : (UserEntity *) newUser;
-(void) removeUserEntity : (UserEntity *) oldUser;

@end
