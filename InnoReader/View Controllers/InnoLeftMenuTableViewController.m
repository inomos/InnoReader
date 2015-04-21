//
//  LeftMenuViewController.m
//  kezhi
//
//  Created by Chong Li on 10/04/2015.
//  Copyright (c) 2015 Koozh Tech. All rights reserved.
//


#import "InnoLeftMenuTableViewController.h"
#import "SlideNavigationContorllerAnimatorFade.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SlideNavigationContorllerAnimatorScale.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"

@implementation InnoLeftMenuTableViewController

#pragma mark - UIViewController Methods -

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.slideOutAnimationEnabled = NO;
    return [super initWithCoder:aDecoder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorColor = [UIColor lightGrayColor];
    [self setInitialTableSelection];
}

#pragma mark - UITableView Delegate & Datasrouce -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // This can be customized
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 20)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Init Table Cell Style
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftMenuCell"];
    [cell.textLabel setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:16.0f]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    NSString *imageName = [NSString stringWithFormat:@"leftMenuIcon_%ld.png", (long)indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imageName];
    
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"首页";
            break;
        case 1:
            cell.textLabel.text = @"第二";
            break;
            
        case 2:
            cell.textLabel.text = @"第三";
            break;
            
        case 3:
            cell.textLabel.text = @"评价";
            break;
        case 4:
            cell.textLabel.text = @"反馈";
            break;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UIViewController *vc;
    
    switch (indexPath.row)
    {
        case 0:
            [[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:NO];
            break;
            
        case 1:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"InnoSecondViewController"];
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                                     withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                             andCompletion:nil];
            break;
            
        case 2:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"InnoThirdViewController"];
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                                     withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                             andCompletion:nil];
            break;
            
        case 3:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"InnoThirdViewController"];
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                                     withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                             andCompletion:nil];
            break;
        case 4:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"InnoMailPageViewController"];
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                                     withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                             andCompletion:nil];
            break;
    }
}

- (void)setInitialTableSelection {
    //Set initial table view selection
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionBottom];
    
}
@end

