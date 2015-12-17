// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by rsimantov.

#import <Foundation/Foundation.h>

#import "PhotosList.h"

NS_ASSUME_NONNULL_BEGIN

/// Protocol for delegate object which accepts notifications about recent viewed photos changes.
@protocol RecentViewedPhotosUpdatedDelegate

/// This method notifies the delegate object that there was an update in the recent viewed photos.
- (void)recentViewedPhotosUpdated;
@end

/// Protocol that defines the functionality for recent viewed photos list.
@protocol RecentViewedPhotosHandler <PhotosList>

/// This method sets the given \c photoData as the last viewed photo.
- (void)addPhotoData:(PhotoData *)photoData;

/// This method registers the given \c delegate for recent viewed photos updates.
- (void)addRecentPhotosViewedUpdatedDelegate:(id<RecentViewedPhotosUpdatedDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
