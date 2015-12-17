// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by rsimantov.

#import "PlacePhotosListTVC.h"

#import "AsynchronousDataLoader.h"
#import "TopPlacesDataFactory.h"

NS_ASSUME_NONNULL_BEGIN

static const int kMaxPhotos = 50;

@interface PlacePhotosListTVC ()
@property (strong, nonatomic) id<PhotosList> photosList;
@end

@implementation PlacePhotosListTVC

#pragma mark -
#pragma mark - PhotosListTVC
#pragma mark -

- (id<PhotosList>)fetchPhotosList {
  return self.photosList;
}

#pragma mark -
#pragma mark Properties
#pragma mark -

- (id<PhotosList>)photosList {
  if (!_photosList) {
    _photosList = [TopPlacesDataFactory photosListOfPlace:self.placeId maxPhotos:kMaxPhotos];
    [self updatePhotosList];
  }
  return _photosList;
}

- (IBAction)updatePhotosList {
  [AsynchronousDataLoader loadData:self.photosList forTableViewController:self];
}

@end

NS_ASSUME_NONNULL_END
