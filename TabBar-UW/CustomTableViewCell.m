//
//  CustomTableViewCell.m
//  TabBar-UW
//
//  Created by Gnrn on 05.02.15.
//  Copyright (c) 2015 Gnrn. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface CustomTableViewCell ()

@property (strong,nonatomic) UIImageView *iconImage;

@end

@implementation CustomTableViewCell

- (void)awakeFromNib {
    float width = self.frame.size.width - 60;
    CGRect imageFrame = CGRectMake(width, 10.0, 30.0, 30.0);
    self.iconImage = [[UIImageView alloc] initWithFrame:imageFrame];
    [self.contentView addSubview:self.iconImage];
    
}

-(void) setUserEntity:(UserEntity *)userEntity{
    _userEntity = userEntity;
    NSString *temp = [_userEntity.firstName stringByAppendingString:@" "];
    [self.textLabel setText:[temp stringByAppendingString: _userEntity.lastName]];
    if (!_userEntity.isEnabled) {
        UIImage *im = [UIImage imageNamed:@"lock.png"];
        _iconImage.image = im;
    }else{
        UIImage *im = [UIImage imageNamed:@"unlock.png"];
        _iconImage.image = im;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
