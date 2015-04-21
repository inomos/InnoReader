//
//  InnoMailPageViewController.m
//  InnoReader
//
//  Created by Chong Li on 21/04/2015.
//  Copyright (c) 2015 Chong Li. All rights reserved.
//

#import "InnoMailPageViewController.h"
#import "InnoLeftMenuTableViewController.h"
#import <MessageUI/MessageUI.h>

@interface InnoMailPageViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation InnoMailPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SlideNavigationController sharedInstance].portraitSlideOffset = self.view.frame.size.width * 0.5;
    [self initMailView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initMailView {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:@"XX App -iOS 意见反馈"];
        [mail setMessageBody:[NSString stringWithFormat:@"\n\n\n\n\n技术信息: \n版本 1.0/iOS %@", [[UIDevice currentDevice] systemVersion]] isHTML:NO];
        [mail setToRecipients:@[@"domainName@email.com"]];
        
        [self presentViewController:mail animated:YES completion:NULL];
    }
    else
    {
        NSLog(@"This device cannot send email");
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UIViewController *vc;
    
    switch (result) {
        case MFMailComposeResultSent:
            //NSLog(@"You sent the email.");
            [self dismissViewControllerAnimated:YES completion:NULL];
            break;
        case MFMailComposeResultSaved:
        case MFMailComposeResultCancelled:
        case MFMailComposeResultFailed:
            [self dismissViewControllerAnimated:YES completion:NULL];
            [self resetLeftMenuSelection];
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"InnoMainTableViewController"];
            [[SlideNavigationController sharedInstance] popViewControllerAnimated:YES];
            break;
        default:
            [self dismissViewControllerAnimated:YES completion:NULL];
            [self resetLeftMenuSelection];
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"InnoMainTableViewController"];
            [[SlideNavigationController sharedInstance] popViewControllerAnimated:YES];
            break;
    }
    
    //[self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)resetLeftMenuSelection {
    InnoLeftMenuTableViewController *leftVC = (InnoLeftMenuTableViewController *)[SlideNavigationController sharedInstance].leftMenu;
    [leftVC setInitialTableSelection];
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}


@end
