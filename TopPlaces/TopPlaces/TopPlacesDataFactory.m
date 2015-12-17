// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Reuven Siman Tov.

#import "TopPlacesDataFactory.h"

#import "FlickrFetcher/FlickrFetcher.h"
#import "FlickrPlacesList.h"
#import "FlickrPlacePhotos.h"
#import "UserDefaultsRecentViewedPhotos.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TopPlacesDataFactory

+ (id<PlacesList>)placesList {
  return [[FlickrPlacesList alloc] initWithURL:[FlickrFetcher URLforTopPlaces]];
}

+ (id<PhotosList>)photosListOfPlace:(NSString *)placeId maxPhotos:(NSInteger)maxPhotos {
  return [[FlickrPlacePhotos alloc] initWithPlaceId:placeId maxPhotos:maxPhotos];
}

+ (id<RecentViewedPhotosHandler>)recentViewdPhotos {
  return [UserDefaultsRecentViewedPhotos sharedUserDefaultsRecentViewedPhotos];
}

@end

NS_ASSUME_NONNULL_END
