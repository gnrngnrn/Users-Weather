//
//  CustomTableViewCell.h
//  TabBar-UW
//
//  Created by Gnrn on 05.02.15.
//  Copyright (c) 2015 Gnrn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserEntity.h"

@interface CustomTableViewCell : UITableViewCell

@property (weak,nonatomic) UserEntity *userEntity;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *customImage;

@end
