//
//  InnoSecondViewController.m
//  InnoReader
//
//  Created by Chong Li on 21/04/2015.
//  Copyright (c) 2015 Chong Li. All rights reserved.
//

#import "InnoSecondViewController.h"
#import "InnoThirdViewController.h"
#import "CarbonKit.h"

@interface InnoSecondViewController () <CarbonTabSwipeDelegate>
{
    CarbonTabSwipeNavigation *tabSwipe;
}

@end

@implementation InnoSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.title = @"第二视图控制器";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    NSArray *names = @[@"ONE", @"TWO", @"THREE"];
    UIColor *byteClubBlue = [UIColor colorWithRed:61/255.0f
                                            green:154/255.0f
                                             blue:232/255.0f
                                            alpha:1.0f];
    tabSwipe = [[CarbonTabSwipeNavigation alloc] createWithRootViewController:self tabNames:names tintColor:byteClubBlue delegate:self];
    [tabSwipe setNormalColor:[UIColor colorWithWhite:1 alpha:0.8]];
    [tabSwipe setSelectedColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Carbon Tab Swipe Delegate

- (UIViewController *)tabSwipeNavigation:(CarbonTabSwipeNavigation *)tabSwipe viewControllerAtIndex:(NSUInteger)index {
    
    if (index == 0) {
        InnoThirdViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InnoThirdViewController"];
        return viewController;
    } else if (index == 1) {
        InnoThirdViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InnoThirdViewController"];
        return viewController;
    } else {
        InnoThirdViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InnoThirdViewController"];
        return viewController;
    }
}


@end
