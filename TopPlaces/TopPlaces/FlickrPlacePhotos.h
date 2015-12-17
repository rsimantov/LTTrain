// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by rsimantov.

#import <Foundation/Foundation.h>

#import "PhotosList.h"

NS_ASSUME_NONNULL_BEGIN

/// Ojbect that implements the \c PlacePhotos protocol for Flicker place Id.
@interface FlickrPlacePhotos : NSObject <PhotosList>

- (instancetype)init NS_UNAVAILABLE;

/// Constructor that creates a \c FlickrPlacePhotos object for the given \c placeId,
/// with limited \c maxPhotos number of photos.
- (instancetype)initWithPlaceId:(NSString *)placeId
                      maxPhotos:(NSInteger)maxPhotos NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
