//
//  MasterViewController.m
//  UW
//
//  Created by Gnrn on 29.01.15.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import "UsersViewController.h"

#import "DetailUserViewController.h"

@interface UsersViewController () {
    NSMutableArray *_objects;
}
@end

@implementation UsersViewController
@synthesize allUsers,singletonArray;

static NSString *cellIdentifier =@"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithTitle:@"+" style:UIBarButtonSystemItemAction target:self action:@selector(addNewUser:)];
    self.navigationItem.rightBarButtonItem = barItem;
    self.title = @"All Users";

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:@"AllUsers"];
    allUsers = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    if (!allUsers) {
        allUsers = [[NSMutableArray alloc]init];
    }
    NSSortDescriptor *descriptor =[[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    NSSortDescriptor *descriptor2 =[[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    NSArray *sorters = @[descriptor,descriptor2];
    NSArray *sortedUsers = [ allUsers sortedArrayUsingDescriptors:sorters];
    allUsers = [sortedUsers mutableCopy];
    singletonArray = [SingletonUsersArray sharedInstance];
    singletonArray.usersArray = allUsers;
}
-(IBAction) addNewUser:(id)sender{
    DetailUserViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailUserViewControllerID"];
    UserEntity *entity = [[UserEntity alloc] init];
    controller.userEntity = entity;
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return allUsers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImageView *imageView;
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    UserEntity *current = [allUsers objectAtIndex:indexPath.row];
    NSString *temp = [current.firstName stringByAppendingString:@" "];
    [cell.textLabel setText:[temp stringByAppendingString: current.lastName]];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;

    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [allUsers removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
       
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailUserViewController *controller = [segue destinationViewController];
    NSIndexPath *indePath = [self.tableView indexPathForSelectedRow];
    UserEntity *ent = [allUsers objectAtIndex:[indePath row]];
    controller.userEntity = ent;
    controller.delegate = self;
}

@end
