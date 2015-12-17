// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by rsimantov.

#import "RecentPhotosTVC.h"

#import "AsynchronousDataLoader.h"
#import "RecentViewedPhotosHandler.h"
#import "TopPlacesDataFactory.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecentPhotosTVC () <RecentViewedPhotosUpdatedDelegate>

@property (strong, nonatomic) id<RecentViewedPhotosHandler> photosList;

@end

@implementation RecentPhotosTVC

#pragma mark -
#pragma mark PhotosListTVC
#pragma mark -

- (id<PhotosList>)fetchPhotosList {
  return self.photosList;
}

#pragma mark -
#pragma mark RecentViewedPhotosUpdatedDelegate
#pragma mark -

- (void)recentViewedPhotosUpdated {
  [self updatePhotosList];
}

#pragma mark -
#pragma mark Properties
#pragma mark -

- (id<RecentViewedPhotosHandler>)photosList {
  if (!_photosList) {
    _photosList = [TopPlacesDataFactory recentViewdPhotos];
    [_photosList addRecentPhotosViewedUpdatedDelegate:self];
    [self updatePhotosList];
  }
  return _photosList;
}

- (IBAction)updatePhotosList {
  [AsynchronousDataLoader loadData:self.photosList forTableViewController:self];
}

@end

NS_ASSUME_NONNULL_END
