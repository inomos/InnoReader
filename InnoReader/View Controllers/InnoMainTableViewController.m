//
//  InnoMainTableViewController.m
//  InnoReader
//
//  Created by Chong Li on 20/04/2015.
//  Copyright (c) 2015 Chong Li. All rights reserved.
//

#import "InnoMainTableViewController.h"
#import "BWMCoverView.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "InnoArticleEntity.h"
#import "InnoArticleTableViewCell.h"
#import "InnoArticleDetailViewController.h"
#import "InnoHelperClass.h"

@interface InnoMainTableViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *coverFlowImageView;
@property (nonatomic, strong) NSMutableArray *articles;
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation InnoMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initController];
    [self initCoverFlow];
    [self initTableView];
    [self fetchArticlesAndAppendToEnd:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _articles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"InnoArticleTableViewCell";
    InnoArticleTableViewCell *cell = (InnoArticleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[InnoArticleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setupArticleCell];
    
    InnoArticleEntity *article = self.articles[indexPath.row];
    NSString *imageURL = article.thumbnails[0];
    
    [cell.thumbnailImage sd_setImageWithURL:[NSURL URLWithString:imageURL]
                           placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    cell.titleLabel.text = article.title;
    cell.dateLabel.text = article.dateString;
    //cell.dateLabel.text = [KeZhiHelperClass getFormattedDateString:story.dateString];
    //story.dateString = [KeZhiHelperClass getFormattedDateString:storiesJSON[@"date"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.tableView.frame.size.height * 0.15;
}

#pragma mark - Initialization Code

- (NSMutableArray *)articles
{
    if (!_articles) {
        _articles = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return _articles;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
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
            [weakSelf fetchArticlesAndAppendToEnd:NO];
            [weakSelf.tableView.header endRefreshing];
        });
    }];
    
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf fetchArticlesAndAppendToEnd:YES];
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

// Init Top Cover Flow
- (void)initCoverFlow {
    
    [_coverFlowImageView setFrame:CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height * 0.25)];
    // 此数组用来保存BWMCoverViewModel
    __block NSMutableArray *realArray = [[NSMutableArray alloc] init];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *coverFlowSession = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask *dataTask =
    [coverFlowSession dataTaskWithURL:[InnoHelperClass getURLForTopArticles]
                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                        if (!error) {
                            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
                            if(httpResp.statusCode == 200) {
                                NSError *jsonError;
                                NSDictionary *topArticlesJSON = [NSJSONSerialization JSONObjectWithData:data
                                                                                               options:NSJSONReadingAllowFragments
                                                                                                 error:&jsonError];
                                if (!jsonError) {
                                    NSArray *contentsOfArticles = topArticlesJSON[@"top_stories"];
                                    NSMutableArray *articlesRetrieved = [[NSMutableArray alloc] init];
                                    
                                    for (NSDictionary *data in contentsOfArticles) {
                                        NSString *title = data[@"title"];
                                        NSString *imgURL = data[@"image"];
                                        InnoArticleEntity *article = [[InnoArticleEntity alloc] initWithJSONData:data];
                                        [articlesRetrieved addObject:article];
                                        
                                        BWMCoverViewModel *model = [[BWMCoverViewModel alloc] initWithImageURLString:imgURL imageTitle:title];
                                        [realArray addObject:model];
                                    }
                                    
                                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                                    //SecondViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"SecondViewController"];
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        BWMCoverView *coverView = [BWMCoverView coverViewWithModels:realArray andFrame:self.coverFlowImageView.frame andPlaceholderImageNamed:BWMCoverViewDefaultImage andClickdCallBlock:^(NSInteger index) {
                                            InnoArticleDetailViewController *articleDetailVC = [mainStoryboard instantiateViewControllerWithIdentifier: @"InnoArticleDetailViewController"];
                                            //NSLog(@"你点击了第%d个图片", index);
                                            articleDetailVC.session = _session;
                                            articleDetailVC.article = articlesRetrieved[index];
                                            //[storyDetailVC fetchStoryDetail];
                                            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:articleDetailVC
                                                                                                     withSlideOutAnimation:YES
                                                                                                             andCompletion:nil];
                                            
                                        }];
                                        [self.view addSubview:coverView];
                                        
                                        // 滚动视图每一次滚动都会回调此方法
                                        [coverView setScrollViewCallBlock:^(NSInteger index) {
                                            //NSLog(@"当前滚动到第%d个页面", index);
                                        }];
                                        
                                        // 请打开下面的东西逐个调试
                                        [coverView setAutoPlayWithDelay:3.0]; // 设置自动播放
                                        coverView.imageViewsContentMode = UIViewContentModeScaleAspectFill; // 图片显示内容模式模式
                                        // [coverView stopAutoPlayWithBOOL:YES]; // 停止自动播放
                                        // [coverView stopAutoPlayWithBOOL:NO]; // 恢复自动播放
                                        // [coverView setAnimationOption:UIViewAnimationOptionTransitionCurlUp]; // 设置切换动画
                                        //coverView.titleLabel.hidden = YES; //隐藏TitleLabel
                                        
                                        //  主要有以下UI成员：
                                        //    coverView2.scrollView
                                        //    coverView2.pageControl
                                        //    coverView2.titleLabel
                                        // 详情请查看接口文件
                                        
                                        [coverView updateView]; //修改属性后必须调用updateView方法，更新视图
                                    });
                                }
                            } else {
                                //Handle HTTP Error
                            }
                        }
                    }];
    [dataTask resume];
}

#pragma mark - Init Search Picker View and Pop Up
- (InnoSearchPickerViewController *)searchPickerView
{
    if (!_searchPickerView) {
        _searchPickerView = [[InnoSearchPickerViewController alloc] initWithStyle:UITableViewStylePlain];
        _searchPickerView.delegate = self;
    }
    return _searchPickerView;
}

- (WYPopoverController *)searchPickerPopup
{
    if (!_searchPickerPopup) {
        _searchPickerPopup = [[WYPopoverController alloc] initWithContentViewController:self.searchPickerView];
        _searchPickerPopup.delegate = self;
    }
    return _searchPickerPopup;
}

- (IBAction)showSearchPickerView:(UIBarButtonItem *)sender
{
    [self.searchPickerPopup presentPopoverFromBarButtonItem:sender
                                   permittedArrowDirections:WYPopoverArrowDirectionRight
                                                   animated:YES
                                                    options:WYPopoverAnimationOptionScale];
}


#pragma mark - Fetch Articles Methods
- (void)fetchArticlesAndAppendToEnd:(BOOL)appendResultsToEnd {
    
    [self showProgressBar];

    // For Demo, it is hardcoded to 20150418
    NSString *urlStr = [NSString stringWithFormat:@"http://news.at.zhihu.com/api/4/news/before/%@", @"20150418"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURLSessionDataTask *dataTask =
    [_session dataTaskWithURL:url
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                if (!error) {
                    NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
                    if(httpResp.statusCode == 200) {
                        NSError *jsonError;
                        NSDictionary *articlesJSON = [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:NSJSONReadingAllowFragments
                                                                                      error:&jsonError];
                        
                        NSMutableArray *articlesRetrieved = [[NSMutableArray alloc] init];
                        if (!jsonError) {
                            NSArray *contentsOfArticles = articlesJSON[@"stories"];
                            
                            for (NSDictionary *data in contentsOfArticles) {
                                InnoArticleEntity *article = [[InnoArticleEntity alloc] initWithJSONData:data];
                                article.dateString = articlesJSON[@"date"];
                                [articlesRetrieved addObject:article];
                            }
                            
                            if (appendResultsToEnd) {
                                [self.articles addObjectsFromArray:articlesRetrieved];
                            } else {
                                NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange: NSMakeRange(0,[articlesRetrieved count])];
                                [self.articles insertObjects:articlesRetrieved atIndexes:indexes];
                            }
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                [self hideProgressBar];
                                [self.tableView reloadData];
                            });
                        }
                    } else {
                        //Handle HTTP Error
                    }
                }
            }];
    [dataTask resume];
}

- (void)showProgressBar {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideProgressBar {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark - Delegate Methods
- (void)selectedSearchMethod:(NSString *)methodName {
    if ([methodName isEqual:@"第一分类"]) {
        //
    }
    else {
        //
    }
    [self.searchPickerPopup dismissPopoverAnimated:YES];
}

#pragma mark - Navigation Methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    InnoArticleDetailViewController *articleDetailVC = (InnoArticleDetailViewController *)segue.destinationViewController;
    articleDetailVC.session = _session;
    
    if ([segue.identifier isEqualToString:@"showArticleDetail"]) {
        InnoArticleEntity *article = self.articles[[self.tableView indexPathForSelectedRow].row];
        articleDetailVC.article = article;
    }
}

@end
