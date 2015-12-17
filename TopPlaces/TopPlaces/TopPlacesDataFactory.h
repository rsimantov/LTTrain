// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Reuven Siman Tov.

#import <Foundation/Foundation.h>

#import "PhotosList.h"
#import "PlacesList.h"
#import "RecentViewedPhotosHandler.h"

NS_ASSUME_NONNULL_BEGIN

/// Class that implements a factory for the relevant Top Places data containers.
@interface TopPlacesDataFactory : NSObject

/// This method returns a \c PlacesList data container with Flickr's top places.
+ (id<PlacesList>)placesList;

/// This method returns a \c PhotosList data container for the given \c placeId,
/// and limited number of photos according to \c maxPhotos..
+ (id<PhotosList>)photosListOfPlace:(NSString *)placeId maxPhotos:(NSInteger)maxPhotos;

/// This method returns a \c RecentViewedPhotosHandler data container of recent shown photos.
+ (id<RecentViewedPhotosHandler>)recentViewdPhotos;

@end

NS_ASSUME_NONNULL_END
