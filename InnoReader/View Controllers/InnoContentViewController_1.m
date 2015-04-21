//
//  InnoContentTableViewController_1.m
//  InnoReader
//
//  Created by Chong Li on 21/04/2015.
//  Copyright (c) 2015 Chong Li. All rights reserved.
//

#import "InnoContentViewController_1.h"
#import "MJRefresh.h"

@interface InnoContentViewController_1 ()

@end

@implementation InnoContentViewController_1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initController];
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initController
{
    [SlideNavigationController sharedInstance].portraitSlideOffset = self.view.frame.size.width * 0.5;
    [SlideNavigationController sharedInstance].enableShadow = YES;
    
    // Change bar button item color to white
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)initTableView
{
    [self.tableView.header setTitle:@"" forState:MJRefreshHeaderStateIdle];
    [self.tableView.footer setTitle:@"" forState:MJRefreshFooterStateIdle];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //[weakSelf fetchArticlesAndAppendToEnd:NO];
            [weakSelf.tableView.header endRefreshing];
        });
    }];
    
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //[weakSelf fetchArticlesAndAppendToEnd:YES];
            [weakSelf.tableView.footer endRefreshing];
        });
    }];
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.backgroundView = nil;
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InnoContentTableViewCell_1" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", (int)indexPath.row];
    return cell;
}
@end
