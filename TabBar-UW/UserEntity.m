//
//  UserEntity.m
//  Users_Wheather
//
//  Created by Gnrn on 28.01.15.
//  Copyright (c) 2015 Gnrn. All rights reserved.
//

#import "UserEntity.h"

@implementation UserEntity
@synthesize firstName,lastName,userDescription,age,isEnabled;
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.firstName forKey:@"FirstName"];
    [coder encodeObject:self.lastName forKey:@"LastName"];
    [coder encodeObject:self.userDescription forKey:@"UserDescription"];
    NSNumber *n = [NSNumber numberWithInt:self.age];
    [coder encodeObject: n forKey:@"Age"];
    [coder encodeBool:(self.isEnabled) forKey:@"IsEnabled"];
    
}
- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        firstName = [coder decodeObjectForKey:@"FirstName"];
        lastName = [coder decodeObjectForKey:@"LastName"];
        userDescription = [coder decodeObjectForKey:@"UserDescription"];
        NSNumber *n = [coder decodeObjectForKey:@"Age"];
        age = (int)[n integerValue];
        isEnabled = [coder decodeBoolForKey:@"IsEnabled"];
        
    }
    return self;
}
@end
