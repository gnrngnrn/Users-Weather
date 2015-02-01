//
//  DetailViewController.h
//  UW
//
//  Created by Gnrn on 29.01.15.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingletonUsersArray.h"
#import "UserEntity.h"
#import "UsersViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "AgePickerViewController.h"
@class UsersViewController;
@interface DetailUserViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *agePicker;
@property (weak, nonatomic) IBOutlet UISwitch *enableTumpler;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextView *describeField;
@property (weak, nonatomic) IBOutlet UILabel *agePerformanceLable;
////
@property (nonatomic,assign) SingletonUsersArray *singletonArray;
@property (strong, nonatomic) UserEntity *userEntity;
@property (strong,nonatomic) UsersViewController *delegate;
////
- (IBAction)imageChose:(id)sender;
- (IBAction)performAgePick:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;
////
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker;

@end
