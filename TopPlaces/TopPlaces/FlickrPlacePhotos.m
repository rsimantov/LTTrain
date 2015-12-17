// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by rsimantov.

#import "FlickrPlacePhotos.h"

#import "FlickrFetcher/FlickrFetcher.h"

NS_ASSUME_NONNULL_BEGIN

@interface FlickrPlacePhotos ()
@property (strong, nonatomic, nullable) NSArray *photos;
@property (strong, nonatomic) NSString *placeId;
@property (nonatomic) NSInteger maxPhotos;
@end

@implementation FlickrPlacePhotos

- (instancetype)initWithPlaceId:(NSString *)placeId maxPhotos:(NSInteger)maxPhotos {
  if (self = [super init]) {
    self.placeId = placeId;
    self.maxPhotos = maxPhotos;
  }
  return self;
}

#pragma mark -
#pragma mark Loadable
#pragma mark -

- (void)load {
  self.photos = nil;
  NSData *jsonResults =
      [NSData dataWithContentsOfURL:[FlickrFetcher URLforPhotosInPlace:self.placeId
                                                            maxResults:(int)self.maxPhotos]];
  NSDictionary *propertyList =
      [NSJSONSerialization JSONObjectWithData:jsonResults options:0 error:NULL];
  self.photos = [propertyList valueForKeyPath:FLICKR_RESULTS_PHOTOS];
}

#pragma mark -
#pragma mark PhotosList
#pragma mark -

- (NSUInteger)photosCount {
  return  [self.photos count];
}

- (PhotoData *)photoData:(NSUInteger)index {
  NSAssert2(index < [self photosCount],
            @"index is %ld while photos count is %ld", index, [self photosCount]);
  return [[PhotoData alloc] initWithPhotoURL:[FlickrFetcher URLforPhoto:self.photos[index]
                                                                 format:FlickrPhotoFormatOriginal]
                                  photoTitle:[self.photos[index] valueForKeyPath:FLICKR_PHOTO_TITLE]
                            photoDescription:[self.photos[index]
                                              valueForKeyPath:FLICKR_PHOTO_DESCRIPTION]];
}

#pragma mark -
#pragma mark Properties
#pragma mark -

- (NSArray * _Nullable)photos {
  if (!_photos) {
    _photos = [[NSArray alloc] init];
  }
  return _photos;
}

@end

NS_ASSUME_NONNULL_END
