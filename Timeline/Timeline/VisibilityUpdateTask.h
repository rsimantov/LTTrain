// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Reuven Siman Tov.

#import "PhotoUpdateTask.h"

#import "PhotoData.h"

NS_ASSUME_NONNULL_BEGIN

@interface VisibilityUpdateTask <PhotoUpdateTask> : NSObject

- (instancetype)initWithPhotoData:(PhotoData *) andVisiability:(NSUInteger)visibility;

@end

NS_ASSUME_NONNULL_END
