// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Reuven Siman Tov.

#import "AsynchronousDataLoader.h"

NS_ASSUME_NONNULL_BEGIN

@implementation AsynchronousDataLoader

+ (void)loadData:(id<Loadable>)loadableData forTableViewController:(UITableViewController *)tvc {
  [tvc.refreshControl beginRefreshing];
  dispatch_async(dispatch_queue_create("UITableViewController data loader", NULL),
                 ^{
                   [loadableData load];
                   dispatch_async(dispatch_get_main_queue(),
                                  ^{
                                    [tvc.refreshControl endRefreshing];
                                    [tvc.tableView reloadData];
                                  });
                 });
}

@end

NS_ASSUME_NONNULL_END
