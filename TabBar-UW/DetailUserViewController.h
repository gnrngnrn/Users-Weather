//
//  DetailViewController.h
//  UW
//
//  Created by Gnrn on 29.01.15.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserEntity.h"
#import "UsersViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "UsersController.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@class UsersViewController;

@interface DetailUserViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *ageButton;
@property (weak, nonatomic) IBOutlet UISwitch *enableTumpler;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextView *describeField;
@property (weak, nonatomic) IBOutlet UIPickerView *agePicker;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;

@property (strong, nonatomic) UserEntity *userEntity;
@property (strong,nonatomic) UsersViewController *delegate;
@property (nonatomic,strong) UsersController *usersController;
@property (strong, nonatomic) NSMutableArray *agesVariants;
@property (strong, nonatomic) NSString *platformD;
@property (nonatomic) float offSet;

- (IBAction)imageChose:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker;

typedef void (^ALAssetsLibraryAssetForURLResultBlock)(ALAsset *asset);
typedef void (^ALAssetsLibraryAccessFailureBlock)(NSError *errorAsset);

@end
