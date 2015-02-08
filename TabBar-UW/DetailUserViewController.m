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

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStyleDone target:self action:@selector(editUser:)];
    self.navigationItem.rightBarButtonItem = barItem;
    self.firstNameField.text = self.userEntity.firstName;
    self.lastNameField.text = self.userEntity.lastName;
    self.describeField.text = self.userEntity.userDescription;
    (self.userEntity.isEnabled) ? [self.enableTumpler setOn:YES] : [self.enableTumpler setOn:NO];
    if (self.userEntity.imageURL) {
        [self retrieveImageFromAssetCatalogByURL:self.userEntity.imageURL];
    }
    [self.ageButton setTitle:[NSString stringWithFormat:@"%i",self.userEntity.age] forState:UIControlStateNormal];
    [self.ageButton setEnabled:NO];
    [self.imageButton setEnabled:NO];
    [self.imageButton setHidden:YES];
    self.platformD = [self platformString];
    self.offSet = [self chooseOffset];
}

-(IBAction)editUser:(id)sender
{
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveUser:)];
    self.navigationItem.rightBarButtonItem = barItem;
    [self.imageButton setEnabled:YES];
    [self.imageButton setHidden:NO];
    [_firstNameField setEnabled:YES];
    [_lastNameField setEnabled:YES];
    [_describeField setEditable:YES];
    [_describeField setSelectable:YES];
    [_enableTumpler setEnabled:YES];
    [_ageButton setEnabled:NO];
    [_ageButton setHidden:YES];
    [_agePicker setHidden:NO];
    _agePicker.delegate =self;
    _agePicker.dataSource = self;
    _agesVariants = [[NSMutableArray alloc]initWithCapacity:44];
    for ( int i = 18 ; i <= 60 ; i ++ ){
        [_agesVariants addObject:[NSNumber numberWithInt:i]];
    }
}

-(IBAction) saveUser:(id)sender
{
    NSString *imageURL = _userEntity.imageURL;
    [_usersController removeUserEntity: _userEntity];
    _userEntity = [[UserEntity alloc] init];
    _userEntity.firstName = _firstNameField.text;
    _userEntity.lastName = _lastNameField.text;
    _userEntity.userDescription = _describeField.text;
    NSInteger row = [self.agePicker selectedRowInComponent:0];
    _userEntity.age = [[self.agesVariants objectAtIndex:row] intValue];
    _userEntity.imageURL = imageURL;
    _userEntity.isEnabled = ([_enableTumpler isOn]) ? YES : NO;
    [_usersController addNewUserEntity: _userEntity];
    [_usersController sortArrayOfUsers];
    [_usersController saveToPlist];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)imageChose:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeSavedPhotosAlbum)]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil];
        picker.allowsEditing = NO;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    [self dismissViewControllerAnimated:YES completion:nil];
    if ([mediaType isEqualToString: (NSString *) kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        _imageView.image = image;
        NSURL *imUrl = [info valueForKey:UIImagePickerControllerReferenceURL];
        NSString*path = [imUrl description];
        _userEntity.imageURL = path;
    }
}

-(void) retrieveImageFromAssetCatalogByURL : (NSString *) path
{
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *rep = [myasset defaultRepresentation];
        CGImageRef iref = [rep fullResolutionImage];
        if (iref) {
            UIImage *largeimage = [UIImage imageWithCGImage:iref];
            _imageView.image = largeimage;
        }
    };
    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
    {
        NSLog(@"Cant get image - %@",[myerror localizedDescription]);
    };
    if(path && [path length] && ![[path pathExtension] isEqualToString:(NSString *) kUTTypeImage])
    {
        NSURL *asseturl = [NSURL URLWithString:path];
        ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
        [assetslibrary assetForURL:asseturl
                       resultBlock:resultblock
                      failureBlock:failureblock];
    }
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender {
    [self.firstNameField resignFirstResponder];
    [self.lastNameField resignFirstResponder];
    [self.describeField resignFirstResponder];
}


#pragma mark -
#pragma mark Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [self.agesVariants count];
}


#pragma mark Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)personInfoPicker titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSNumber *n = [self.agesVariants objectAtIndex:row];
    NSString *n1 = [n stringValue];
    return n1;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (self.offSet == 0.0) {
        return;
    }
    if ([textView isEqual:self.describeField]){
        if (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
        else if (self.view.frame.origin.y < 0)
        {
            [self setViewMovedUp:NO];
        }
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (self.offSet == 0.0) {
        return;
    }
    if ([textView isEqual:self.describeField])
    {
        if (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
        else if (self.view.frame.origin.y < 0)
        {
            [self setViewMovedUp:NO];
        }
    }
}
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        rect.origin.y -= self.offSet;
        rect.size.height += self.offSet;
    }
    else
    {
        rect.origin.y += self.offSet;
        rect.size.height -= self.offSet;
    }
    self.view.frame = rect;
    [UIView commitAnimations];
}

- (NSString *) platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

- (NSString *) platformString{
    NSString *platform = [self platform];
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    return platform;
}
-(float)chooseOffset{
    if ([self.platformD isEqualToString:@"iPhone 4S"]) {
        return 250.0;
    }else if ([self.platformD isEqualToString:@"iPhone 4"]) {
        return 150.0;
    }else if ([self.platformD isEqualToString:@"iPhone 6"]) {
        return 200.0;
    }else if ([self.platformD isEqualToString:@"Simulator"]) {
        return 200.0;
    }else{
        return 0.0;
    }
    
}
@end
