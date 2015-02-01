//
//  AppDelegate.h
//  TabBar-UW
//
//  Created by Gnrn on 01.02.15.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingletonUsersArray.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
////
@property (nonatomic,assign) SingletonUsersArray *singletonArray;

@end
