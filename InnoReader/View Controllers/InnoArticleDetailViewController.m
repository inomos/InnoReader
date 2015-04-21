//
//  InnoArticleDetailViewController.m
//  InnoReader
//
//  Created by Chong Li on 21/04/2015.
//  Copyright (c) 2015 Chong Li. All rights reserved.
//

#import "InnoArticleDetailViewController.h"
#import "InnoHelperClass.h"
#import "MBProgressHUD.h"

@interface InnoArticleDetailViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation InnoArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self fetchArticleDetail];
}

// This Fetch Methods can be customized
- (void)fetchArticleDetail {
    [MBProgressHUD showHUDAddedTo:self.webView animated:YES];
    if (self.article) {
        NSURL *articleURL = [InnoHelperClass getURLForArticle:self.article.articleId];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSURLSessionDataTask *dataTask = [_session dataTaskWithURL:articleURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (!error) {
                NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
                if(httpResp.statusCode == 200) {
                    NSError *jsonError;
                    NSDictionary *articleJSON = [NSJSONSerialization JSONObjectWithData:data
                                                                              options:NSJSONReadingAllowFragments
                                                                                error:&jsonError];
                    
                    if (!jsonError) {
                        NSString *embedHTMLOfArticle = articleJSON[@"body"];
                        NSString *cssOfArticle = articleJSON[@"css"][0];
                        embedHTMLOfArticle = [embedHTMLOfArticle stringByReplacingOccurrencesOfString:@"\n\n<div class=\"img-place-holder\"></div>\n\n\n\n" withString:@""];
                        
                        NSString *bodyHTML = [NSString stringWithFormat:@"<html><head><link href='%@' rel='stylesheet' type='text/css' /></head><body>%@</body></html>",cssOfArticle, embedHTMLOfArticle];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                            self.webView.opaque = NO;
                            self.webView.backgroundColor = [UIColor clearColor];
                            [self.webView loadHTMLString:bodyHTML baseURL:nil];
                            [MBProgressHUD hideHUDForView:self.webView animated:YES];
                        });
                    }
                } else {
                    //Handle HTTP Error
                }
            }
        }];
        [dataTask resume];
    }
}
@end
