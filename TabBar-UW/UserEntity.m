//
//  UserEntity.m
//  Users_Wheather
//
//  Created by Gnrn on 28.01.15.
//  Copyright (c) 2015 Gnrn. All rights reserved.
//

#import "UserEntity.h"

@implementation UserEntity

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.firstName forKey:@"FirstName"];
    [coder encodeObject:self.lastName forKey:@"LastName"];
    [coder encodeObject:self.userDescription forKey:@"UserDescription"];
    [coder encodeObject:self.imageURL forKey:@"ImageURL"];
    NSNumber *n = [NSNumber numberWithInt:self.age];
    [coder encodeObject: n forKey:@"Age"];
    [coder encodeBool:(self.isEnabled) forKey:@"IsEnabled"];
    
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.firstName = [coder decodeObjectForKey:@"FirstName"];
        self.lastName = [coder decodeObjectForKey:@"LastName"];
        self.userDescription = [coder decodeObjectForKey:@"UserDescription"];
        self.imageURL = [coder decodeObjectForKey:@"ImageURL"];
        NSNumber *n = [coder decodeObjectForKey:@"Age"];
        self.age = (int)[n integerValue];
        self.isEnabled = [coder decodeBoolForKey:@"IsEnabled"];
        
    }
    return self;
}
@end
