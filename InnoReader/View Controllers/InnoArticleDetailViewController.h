//
//  InnoArticleDetailViewController.h
//  InnoReader
//
//  Created by Chong Li on 21/04/2015.
//  Copyright (c) 2015 Chong Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InnoArticleEntity.h"

@interface InnoArticleDetailViewController : UIViewController
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) InnoArticleEntity *article;
@end
