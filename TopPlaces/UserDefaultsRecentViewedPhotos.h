// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by rsimantov.

#import <Foundation/Foundation.h>

#import "RecentViewedPhotosHandler.h"

NS_ASSUME_NONNULL_BEGIN

/// Ojbect that implements the \c RecentViewedPhotosHandler over the NSUserDefaults.
@interface UserDefaultsRecentViewedPhotos : NSObject <RecentViewedPhotosHandler>

- (instancetype)init NS_UNAVAILABLE;

/// This method returns the singlton object of this class.
+ (UserDefaultsRecentViewedPhotos *)sharedUserDefaultsRecentViewedPhotos;

@end

NS_ASSUME_NONNULL_END
