//
//  AgePickerViewController.m
//  UW
//
//  Created by Gnrn on 29.01.15.
//  Copyright (c) 2015 Gnrn. All rights reserved.
//

#import "AgePickerViewController.h"

@interface AgePickerViewController ()

@end

@implementation AgePickerViewController
@synthesize agesVariants,agePicker,delegateCont;

- (void)viewDidLoad
{
    [super viewDidLoad];
    agePicker.delegate =self;
    agePicker.dataSource = self;
    agesVariants = [[NSMutableArray alloc]initWithCapacity:44];
    for ( int i = 18 ; i <= 60 ; i ++ ){
        [agesVariants addObject:[NSNumber numberWithInt:i]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)doneAction:(id)sender {
    NSInteger row = [self.agePicker selectedRowInComponent:0];
    NSString *selected = [self.agesVariants objectAtIndex:row];
    int age = [selected intValue];
    self.delegateCont.userEntity.age = age;
    [self.delegateCont viewDidLoad];
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1; }
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
@end
