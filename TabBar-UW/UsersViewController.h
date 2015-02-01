//
//  MasterViewController.h
//  UW
//
//  Created by Gnrn on 29.01.15.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingletonUsersArray.h"
#import "UserEntity.h"
#import "DetailUserViewController.h"
@interface UsersViewController : UITableViewController

@property (nonatomic,strong) NSMutableArray *allUsers;

@property (nonatomic,assign) SingletonUsersArray *singletonArray;

@end
