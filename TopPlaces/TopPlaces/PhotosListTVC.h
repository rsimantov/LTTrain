// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by rsimantov.

#import <UIKit/UIKit.h>

#import "PhotosList.h"

NS_ASSUME_NONNULL_BEGIN

/// Abstract class that impelemnts the common functionality of UITableViewController
/// for photos list. The common functionality is setting the table cells data,
/// and showing the selected image in an ImageViewController.
@interface PhotosListTVC : UITableViewController

/// Abstract
/// This abstract method returns PhotosList object that contains the images' data that
/// should be shown by this UITableViewController.
- (id<PhotosList>)fetchPhotosList;

@end

NS_ASSUME_NONNULL_END
