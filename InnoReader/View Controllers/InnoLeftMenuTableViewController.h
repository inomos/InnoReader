//
//  LeftMenuTableViewController.h
//  Kezhi
//
//  Created by Chong Li on 3/04/2015.
//  Copyright (c) 2015 Koozh Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "MBProgressHUD.h"

@interface InnoLeftMenuTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL slideOutAnimationEnabled;
- (void)setInitialTableSelection;
@end
