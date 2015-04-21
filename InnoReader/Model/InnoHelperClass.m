//
//  KeZhiHelperClass.m
//  Kezhi
//
//  Created by Chong Li on 4/04/2015.
//  Copyright (c) 2015 Koozh Tech. All rights reserved.
//

#import "InnoHelperClass.h"

@implementation InnoHelperClass
+ (NSURL *)getURLForArticle:(NSString *)articleId
{
    NSString *urlWithParams = [NSString stringWithFormat:@"http://daily.zhihu.com/api/4/news/%@",[articleId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    return [NSURL URLWithString:urlWithParams];
}

+ (NSURL *)getURLForTopArticles
{
    return [NSURL URLWithString:@"http://news-at.zhihu.com/api/4/news/latest"];
}

+ (NSURL *)getURLForTheme:(NSString *)themeId
{
    NSString *urlStr = [NSString stringWithFormat:@"http://news.at.zhihu.com/api/4/theme/%@", themeId];
    return  [NSURL URLWithString:urlStr];
}

+ (NSURL *)getURLForTheme:(NSString *)themeId Before:(NSString *)storyID
{
    NSString *urlStr = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/theme/%@/before/%@", themeId, storyID];
    return  [NSURL URLWithString:urlStr];
}

+ (NSString *)getFormattedDateString:(NSString *)dateString
{
    NSMutableString *mutableDateString = [NSMutableString stringWithString:dateString];
    [mutableDateString insertString:@"-" atIndex:4];
    [mutableDateString insertString:@"-" atIndex:7];
    return  mutableDateString;
}
@end
