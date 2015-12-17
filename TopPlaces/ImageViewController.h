// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by rsimantov.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// View Controller that shows a given photo in a UIScrollView.
@interface ImageViewController : UIViewController

/// The photo's URL.
/// Setting this property will trigger this object to show the photo.
@property (strong, readwrite, nonatomic) NSURL *imageURL;

@end

NS_ASSUME_NONNULL_END
