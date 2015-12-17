// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Reuven Siman Tov.

NS_ASSUME_NONNULL_BEGIN

/// Protocol that defines load functionionality for an object.
/// Should be implemented by objects that require loading data asynchronously.
@protocol Loadable <NSObject>

/// This method should include the code that should be run asynchronously.
- (void)load;

@end

NS_ASSUME_NONNULL_END
