//
//  KeZhiStoryTableViewCell.m
//  Kezhi
//
//  Created by Chong Li on 3/04/2015.
//  Copyright (c) 2015 Koozh Tech. All rights reserved.
//

#import "KeZhiStoryTableViewCell.h"

@implementation KeZhiStoryTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //self.imageView.frame = CGRectMake(10,10,70,70);
}

- (void)setupStoryCell {
    self.storyCellMainView.layer.cornerRadius = 5;
    self.storyCellMainView.layer.masksToBounds = YES;
}

@end
