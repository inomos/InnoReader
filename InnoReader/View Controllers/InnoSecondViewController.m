//
//  InnoSecondViewController.m
//  InnoReader
//
//  Created by Chong Li on 21/04/2015.
//  Copyright (c) 2015 Chong Li. All rights reserved.
//

#import "InnoSecondViewController.h"

@interface InnoSecondViewController ()

@end

@implementation InnoSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SlideNavigationController sharedInstance].portraitSlideOffset = self.view.frame.size.width * 0.5;;
    // Change bar button item color to white
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (instancetype) init {
    self = [super init];
    if (self) {
        self.view.frame = CGRectMake(0, 0, 320, 200);
    }
    return self;
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
