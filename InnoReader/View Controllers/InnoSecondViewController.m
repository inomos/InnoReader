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
    [SlideNavigationController sharedInstance].portraitSlideOffset = self.view.frame.size.width * 0.5;;
    // Change bar button item color to white
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.title = @"第二视图控制器";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    NSArray *names = @[@"ONE", @"TWO", @"THREE",@"FOUR",@"FIVE"];
    UIColor *byteClubBlue = [UIColor colorWithRed:61/255.0f
                                            green:154/255.0f
                                             blue:232/255.0f
                                            alpha:1.0f];
    tabSwipe = [[CarbonTabSwipeNavigation alloc] createWithRootViewController:self tabNames:names tintColor:[UIColor whiteColor] delegate:self];
    [tabSwipe setNormalColor:byteClubBlue];
    [tabSwipe setSelectedColor:byteClubBlue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initialization Code
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}

# pragma mark - Carbon Tab Swipe Delegate

- (UIViewController *)tabSwipeNavigation:(CarbonTabSwipeNavigation *)tabSwipe viewControllerAtIndex:(NSUInteger)index {
    
    if (index == 0) {
        InnoContentViewController_1 *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InnoContentViewController_1"];
        return viewController;
    } else if (index == 1) {
        InnoContentViewController_2 *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InnoContentViewController_2"];
        return viewController;
    } else {
        InnoContentViewController_2 *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InnoContentViewController_2"];
        return viewController;
    }
}


@end
