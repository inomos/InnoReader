//
//  InnoSearchPickerViewController.h
//  InnoReader
//
//  Created by Chong Li on 21/04/2015.
//  Copyright (c) 2015 Chong Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchPickerDelegate <NSObject>
- (void)selectedSearchMethod:(NSString *)methodName;
@end

@interface InnoSearchPickerViewController : UITableViewController
@property (nonatomic, strong) NSMutableArray *methodNames;
@property (nonatomic, weak)id<SearchPickerDelegate> delegate;
@end
