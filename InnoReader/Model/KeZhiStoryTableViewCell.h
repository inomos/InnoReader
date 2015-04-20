//
//  KeZhiStoryTableViewCell.h
//  Kezhi
//
//  Created by Chong Li on 3/04/2015.
//  Copyright (c) 2015 Koozh Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeZhiStoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImage;
@property (weak, nonatomic) IBOutlet UIView *storyCellMainView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
- (void)setupStoryCell;
@end
