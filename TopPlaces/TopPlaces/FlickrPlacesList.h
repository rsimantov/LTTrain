// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by rsimantov.

#import <Foundation/Foundation.h>

#import "PlacesList.h"

NS_ASSUME_NONNULL_BEGIN

// Ojbect that implements the \c PlacesList protocol for Flicker places list.
@interface FlickrPlacesList : NSObject <PlacesList>

- (instancetype)init NS_UNAVAILABLE;

/// Constructor that creates a \c FlickrPlacesList object for the given \c url.
- (instancetype)initWithURL:(NSURL *)url NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
