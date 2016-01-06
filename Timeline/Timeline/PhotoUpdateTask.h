// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Reuven Siman Tov.

#import <Foundation/Foundation.h>

#import "PhotoData.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PhotoUpdateTask <NSObject>

- (NSString *)webCommand;

- (PhotoData *)photoData;

- (NSUInteger)priority;

@end

NS_ASSUME_NONNULL_END
