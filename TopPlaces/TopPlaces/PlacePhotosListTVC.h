// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by rsimantov.
//

#import "PhotosListTVC.h"

NS_ASSUME_NONNULL_BEGIN

/// UITableViewContoller that implements PhotosListTVC for a given Flickr place Id.
@interface PlacePhotosListTVC : PhotosListTVC

/// The place's Flickr Id
@property (strong, readwrite, nonatomic) NSString *placeId;

@end

NS_ASSUME_NONNULL_END
