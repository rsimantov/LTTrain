// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Reuven Siman Tov.

#import <UIKit/UIKit.h>

#import "Loadable.h"

NS_ASSUME_NONNULL_BEGIN

/// Class that asynchronously loads \c Loadable objects.
@interface AsynchronousDataLoader : NSObject

/// This method loads the given \c loadableData for the given UITableViewController \c tvc.
+ (void)loadData:(id<Loadable>)loadableData forTableViewController:(UITableViewController *)tvc;

@end

NS_ASSUME_NONNULL_END
