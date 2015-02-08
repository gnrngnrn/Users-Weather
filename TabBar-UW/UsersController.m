//
//  UsersController.m
//  TabBar-UW
//
//  Created by Gnrn on 03.02.15.
//  Copyright (c) 2015 Gnrn. All rights reserved.
//

#import "UsersController.h"

@implementation UsersController

-(void)saveToPlist
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory =  [pathList  objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"%@%@",documentsDirectory,@"AllUsers.plist"];
    NSFileManager *m = [NSFileManager defaultManager];
    if ([m fileExistsAtPath:path]) {
        NSError *error;
        [m removeItemAtPath:path error:&error];
        [NSKeyedArchiver archiveRootObject:self.usersArray toFile:path];
    }else{
        [NSKeyedArchiver archiveRootObject:self.usersArray toFile:path];
    }
}

-(void)loadArrayOfUsers
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory =  [pathList  objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"%@%@",documentsDirectory,@"AllUsers.plist"];
    NSFileManager *m = [[NSFileManager alloc] init];
    if ([m fileExistsAtPath:path]) {
        self.usersArray = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }else{
        self.usersArray = [[NSMutableArray alloc] init];
    }
}

-(void)sortArrayOfUsers
{
    NSSortDescriptor *descriptor =[[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    NSSortDescriptor *descriptor2 =[[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    NSArray *sorters = @[descriptor,descriptor2];
    NSArray *sortedUsers = [ self.usersArray sortedArrayUsingDescriptors:sorters];
    self.usersArray = [sortedUsers mutableCopy];
}

-(void)addNewUserEntity:(UserEntity *)newUser
{
    [self.usersArray addObject:newUser];
}

-(void)removeUserEntity:(UserEntity*)oldUser
{
    [self.usersArray removeObject:oldUser];
}
@end
