//
//  InnoArticleTableViewCell.h
//  InnoReader
//
//  Created by Chong Li on 20/04/2015.
//  Copyright (c) 2015 Chong Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InnoArticleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *articleCellMainView;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
- (void)setupArticleCell;
@end
