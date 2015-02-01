//
//  UserEntity.h
//  Users_Wheather
//
//  Created by Gnrn on 28.01.15.
//  Copyright (c) 2015 Gnrn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserEntity : NSObject
@property (nonatomic,strong) NSString *firstName;
@property (nonatomic,strong) NSString *lastName;
@property (nonatomic,strong) NSString *userDescription;
@property (nonatomic) int age;
@property (nonatomic) bool isEnabled;
////
- (void)encodeWithCoder:(NSCoder *)coder;
- (id)initWithCoder:(NSCoder *)coder;
@end
