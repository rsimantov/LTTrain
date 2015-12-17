// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Reuven Siman Tov.

#import <Foundation/Foundation.h>

#import "Loadable.h"
#import "PhotoData.h"

NS_ASSUME_NONNULL_BEGIN

/// Protocol that defines the functionality of a photos list.
/// A photo should have a title, a description and URL.
@protocol PhotosList <Loadable>

/// This method returns the number of photos in the list.
- (NSUInteger)photosCount;

/// This method returns the photo's data of the photo with the given \c index.
- (PhotoData *)photoData:(NSUInteger)index;


@end

NS_ASSUME_NONNULL_END
