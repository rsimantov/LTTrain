// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Reuven Siman Tov.

#import "PhotoUpdateTask.h"

NS_ASSUME_NONNULL_BEGIN

@interface UpdateTasksDispatcher : NSObject

- (void)addUpdateTask:(PhotoUpdateTask *)updateTask completion:(void(^)(NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
