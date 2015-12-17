// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by rsimantov.

#import "PhotosListTVC.h"

#import "ImageViewController.h"
#import "TopPlacesDataFactory.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotosListTVC ()
@property (strong, nonatomic) NSIndexPath *lastIndexPath;
@end

@implementation PhotosListTVC

#pragma mark -
#pragma mark UITableViewController
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self fetchPhotosList] photosCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Photo Cell"
                                                          forIndexPath:indexPath];
  PhotoData *photoData = [[self fetchPhotosList] photoData:indexPath.row];
  cell.textLabel.text = photoData.photoTitle;
  cell.detailTextLabel.text =  photoData.photoDescription;
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//  NSLog(@"Count=%ld\n", [self.splitViewController.viewControllers count]);
  if ([self shouldPerformSegue]) {
    return;
  }
  NSAssert([self.splitViewController.viewControllers count] > 1, @"No detail view in split view");
  id viewController = self.splitViewController.viewControllers[1];
  if (![viewController isKindOfClass:[UINavigationController class]]) {
    return;
  }
  viewController = [((UINavigationController *)viewController).viewControllers firstObject];
  if (![viewController isKindOfClass:[ImageViewController class]]) {
    return;
  }
  [self prepareImageViewController:viewController withIndexPath:indexPath];
}

- (void)prepareImageViewController:(ImageViewController *)imageViewController
                     withIndexPath:(NSIndexPath *)indexPath {
  PhotoData *photoData = [[self fetchPhotosList] photoData:indexPath.row];
  imageViewController.imageURL = photoData.photoURL;
  imageViewController.title = photoData.photoTitle;
  [[TopPlacesDataFactory recentViewdPhotos] addPhotoData:photoData];
  self.lastIndexPath = indexPath;
}

#pragma mark -
#pragma mark ViewController
#pragma mark -

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id _Nullable)sender {
  return [self shouldPerformSegue];
}

- (BOOL)shouldPerformSegue {
  return self.splitViewController.collapsed;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id _Nullable)sender {
  if ((![sender isKindOfClass:[UITableViewCell class]]) ||
      (![segue.identifier isEqualToString:@"Show Photo"])) {
    return;
  }
  [self prepareImageViewController:segue.destinationViewController
                     withIndexPath:[self.tableView indexPathForCell:sender]];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  UIUserInterfaceSizeClass vert = self.splitViewController.traitCollection.verticalSizeClass;
  UIUserInterfaceSizeClass horz = self.splitViewController.traitCollection.horizontalSizeClass;
  if (vert == UIUserInterfaceSizeClassCompact &&
      horz == UIUserInterfaceSizeClassRegular &&
      self.lastIndexPath) {
    [self tableView:self.tableView didSelectRowAtIndexPath:self.lastIndexPath];
  }

}

#pragma mark -
#pragma mark Abstract
#pragma mark -

- (id<PhotosList>)fetchPhotosList {
@throw [NSException exceptionWithName:NSInternalInconsistencyException
                               reason:[NSString
                                       stringWithFormat:@"You must override %@ in a subclass",
                                       NSStringFromSelector(@selector(fetchPhotosList))]
                               userInfo:nil];
}

@end

NS_ASSUME_NONNULL_END
