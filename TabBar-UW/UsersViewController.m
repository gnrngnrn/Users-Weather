//
//  MasterViewController.m
//  UW
//
//  Created by Gnrn on 29.01.15.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import "UsersViewController.h"

#import "DetailUserViewController.h"

@interface UsersViewController ()

@end

@implementation UsersViewController

static NSString *cellIdentifier =@"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithTitle:@"+" style:UIBarButtonItemStyleDone target:self action:@selector(addNewUser:)];
    self.navigationItem.rightBarButtonItem = barItem;
    self.title = @"All Users";
    self.usersController = [[UsersController alloc]init];
    [self.usersController loadArrayOfUsers];
}

-(IBAction) addNewUser:(id)sender
{
    DetailUserViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailUserViewControllerID"];
    [controller setUsersController:_usersController];
    UserEntity *entity = [[UserEntity alloc] init];
    controller.userEntity = entity;
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _usersController.usersArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    UserEntity *current = [_usersController.usersArray objectAtIndex:indexPath.row];
    cell.userEntity = current;
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
        [_usersController.usersArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [_usersController saveToPlist];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailUserViewController *controller = [segue destinationViewController];
    NSIndexPath *indePath = [self.tableView indexPathForSelectedRow];
    UserEntity *ent = [_usersController.usersArray objectAtIndex:[indePath row]];
    controller.userEntity = ent;
    controller.usersController = _usersController;
    controller.delegate = self;
}

@end
