//
//  KeZhiStoryEntity.h
//  Kezhi
//
//  Created by Chong Li on 4/04/2015.
//  Copyright (c) 2015 Koozh Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeZhiStoryEntity : NSObject
@property (nonatomic, strong) NSString *storyId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *dateString;
@property (nonatomic, strong) NSArray *thumbnails;
- (id)initWithJSONData:(NSDictionary *)data;
@end
