//
//  KeZhiHelperClass.h
//  Kezhi
//
//  Created by Chong Li on 4/04/2015.
//  Copyright (c) 2015 Koozh Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InnoHelperClass : NSObject
+ (NSURL *)getURLForStory: (NSString *)storyId;
+ (NSURL *)getURLForTopStories;
+ (NSURL *)getURLForTheme: (NSString *)themeId;
+ (NSURL *)getURLForTheme: (NSString *)themeId Before:(NSString *)storyID;
+ (NSString *)getFormattedDateString: (NSString *)dateString;
@end
