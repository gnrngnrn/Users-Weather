//
//  MasterViewController.h
//  UW
//
//  Created by Gnrn on 29.01.15.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserEntity.h"
#import "DetailUserViewController.h"
#import "UsersController.h"
#import "CustomTableViewCell.h"

@interface UsersViewController : UITableViewController

@property (nonatomic,strong) UsersController *usersController;

@end
