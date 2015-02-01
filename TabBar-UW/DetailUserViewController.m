//
//  DetailViewController.m
//  UW
//
//  Created by Gnrn on 29.01.15.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import "DetailUserViewController.h"

@interface DetailUserViewController ()
@end

@implementation DetailUserViewController
@synthesize firstNameField,lastNameField,enableTumpler,imageView,singletonArray,userEntity,agePicker,delegate,agePerformanceLable,describeField;

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonSystemItemAction target:self action:@selector(saveUser:)];
    self.navigationItem.rightBarButtonItem = barItem;
    firstNameField.text = userEntity.firstName;
    lastNameField.text = userEntity.lastName;
    describeField.text = userEntity.userDescription;
    singletonArray= [SingletonUsersArray sharedInstance];
    if (userEntity.isEnabled) {
        [ enableTumpler setOn:YES];
    }else{
        [enableTumpler setOn:NO];
    }
    agePerformanceLable.text = [NSString stringWithFormat:@"%i",userEntity.age];

}
-(IBAction) saveUser:(id)sender{
    [singletonArray.usersArray removeObject:userEntity];
    userEntity = [[UserEntity alloc] init];
    userEntity.firstName = firstNameField.text;
    userEntity.lastName = lastNameField.text;
    userEntity.userDescription = describeField.text;
    userEntity.age = [agePerformanceLable.text intValue];
    if ([enableTumpler isOn]) {
        userEntity.isEnabled = YES;
    }else{
        userEntity.isEnabled = NO;
    }
    [singletonArray.usersArray addObject:userEntity];
    NSSortDescriptor *descriptor =[[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    NSSortDescriptor *descriptor2 =[[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    NSArray *sorters = @[descriptor,descriptor2];
    NSArray *sortedUsers = [ singletonArray.usersArray sortedArrayUsingDescriptors:sorters];
    singletonArray.usersArray = [sortedUsers mutableCopy];
    self.delegate.allUsers = singletonArray.usersArray;
    [self.delegate.tableView reloadData];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)imageChose:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeSavedPhotosAlbum)]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil];
        picker.allowsEditing = NO;
        [self presentViewController:picker animated:YES completion:nil];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    [self dismissViewControllerAnimated:YES completion:nil];
    if ([mediaType isEqualToString: (NSString *) kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        imageView.image = image;
    }
}
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)performAgePick:(id)sender {
    AgePickerViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AgePickerViewControllerID"];
    controller.delegateCont = self;
    userEntity.firstName = firstNameField.text;
    userEntity.lastName = lastNameField.text;
    userEntity.userDescription = describeField.text;
    userEntity.age = [agePerformanceLable.text intValue];
    if ([enableTumpler isOn]) {
        userEntity.isEnabled = YES;
    }else{
        userEntity.isEnabled = NO;
    }

    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
}
- (IBAction)backgroundTap:(id)sender {
    [self.firstNameField resignFirstResponder];
    [self.lastNameField resignFirstResponder];
    [self.describeField resignFirstResponder];
}

@end
