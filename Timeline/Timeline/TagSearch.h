// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Reuven Siman Tov.

#import <Foundation/Foundation.h>

#import "TimelineSearch.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagSearch <TimelineSearch> : NSObject

- (instancetype)initWithTag:(NSString *)tag;

@end

NS_ASSUME_NONNULL_END
