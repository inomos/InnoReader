//
//  InnoArticleTableViewCell.m
//  InnoReader
//
//  Created by Chong Li on 20/04/2015.
//  Copyright (c) 2015 Chong Li. All rights reserved.
//

#import "InnoArticleTableViewCell.h"

@implementation InnoArticleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupArticleCell {
    self.articleCellMainView.layer.cornerRadius = 5;
    self.articleCellMainView.layer.masksToBounds = YES;
}
@end
