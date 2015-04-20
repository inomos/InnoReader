//
//  KeZhiStoryEntity.m
//  Kezhi
//
//  Created by Chong Li on 4/04/2015.
//  Copyright (c) 2015 Koozh Tech. All rights reserved.
//

#import "KeZhiStoryEntity.h"

@implementation KeZhiStoryEntity

- (id)initWithJSONData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        self.storyId = [data[@"id"] stringValue];
        self.title = data[@"title"];
        self.thumbnails = data[@"images"];
    }
    return self;
}

@end
