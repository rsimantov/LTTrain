// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by rsimantov.

#import "TopPlacesTVC.h"

#import "AsynchronousDataLoader.h"
#import "PlacePhotosListTVC.h"
#import "PlacesList.h"
#import "TopPlacesDataFactory.h"

NS_ASSUME_NONNULL_BEGIN

@interface TopPlacesTVC ()
@property (strong, nonatomic) id<PlacesList> placesList;
@end

@implementation TopPlacesTVC

#pragma mark -
#pragma mark UITableViewController
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.placesList countries] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.placesList placesCountForCountry:[self.placesList countries][section]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Place Cell"
                                                          forIndexPath:indexPath];
  PlaceData *placeData = [self placeDataForIndexPath:indexPath];
  cell.textLabel.text = placeData.placeName;
  cell.detailTextLabel.text = placeData.regionName;
  return cell;
}

- (PlaceData *)placeDataForIndexPath:(NSIndexPath *)indexPath {
  return [self.placesList placeDataForCountry:[self.placesList countries][indexPath.section]
                                      atIndex:indexPath.row];
}

- (NSString * _Nullable)tableView:(UITableView *)tableView
          titleForHeaderInSection:(NSInteger)section {
  return [self.placesList countries][section];
}

#pragma mark -
#pragma mark ViewController
#pragma mark -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id _Nullable)sender {
  if ((![sender isKindOfClass:[UITableViewCell class]]) ||
      (![segue.identifier isEqualToString:@"Display Place"])) {
    return;
  }
  PlacePhotosListTVC *placePhotosListTVC = (PlacePhotosListTVC *)segue.destinationViewController;
  PlaceData *placeData = [self placeDataForIndexPath:[self.tableView indexPathForCell:sender]];
  placePhotosListTVC.placeId = placeData.placeId;
  placePhotosListTVC.title = placeData.placeName;
}

#pragma mark -
#pragma mark Properties
#pragma mark -

- (id<PlacesList>)placesList {
  if (!_placesList) {
    _placesList = [TopPlacesDataFactory placesList];
    [self fetchPlacesList];
  }
  return _placesList;
}

- (IBAction)fetchPlacesList {
  [AsynchronousDataLoader loadData:self.placesList forTableViewController:self];
}


@end

NS_ASSUME_NONNULL_END
