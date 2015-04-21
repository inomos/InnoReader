//
//  InnoMainTableViewController.h
//  InnoReader
//
//  Created by Chong Li on 20/04/2015.
//  Copyright (c) 2015 Chong Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYPopoverController.h"
#import "SlideNavigationController.h"
#import "InnoSearchPickerViewController.h"

@interface InnoMainTableViewController : UITableViewController <WYPopoverControllerDelegate, SearchPickerDelegate>
@property (nonatomic, strong) InnoSearchPickerViewController *searchPickerView;
@property (nonatomic, strong) WYPopoverController *searchPickerPopup;
@end
