//
//  AppDelegate.m
//  InnoReader
//
//  Created by Chong Li on 20/04/2015.
//  Copyright (c) 2015 Chong Li. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initAppearance];
    [self initStoryBoard];
    sleep(2);
    
    return YES;
}

- (void)initAppearance
{
    UIColor *byteClubBlue = [UIColor colorWithRed:61/255.0f
                                            green:154/255.0f
                                             blue:232/255.0f
                                            alpha:1.0f];
    
    // Set appearance info
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UINavigationBar appearance] setBarTintColor:byteClubBlue];
    
    [[UIToolbar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UIToolbar appearance] setBarTintColor:byteClubBlue];
}

- (void)initStoryBoard {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    InnoLeftMenuTableViewController *leftMenu = (InnoLeftMenuTableViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"InnoLeftMenuTableViewController"];
    
    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
    [SlideNavigationController sharedInstance].menuRevealAnimationDuration = .18;
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
