// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by rsimantov.

#import <Foundation/Foundation.h>

#import "Loadable.h"
#import "PlaceData.h"

NS_ASSUME_NONNULL_BEGIN

/// Protocol that defines the functionality of a places list.
/// A place should have an Id, a place name, an area name, and a country name.
@protocol PlacesList <Loadable>

/// This method returns an NSStrings array of country names.
- (NSArray *)countries;

/// This method returns the number of places for the given \c country.
- (NSUInteger)placesCountForCountry:(NSString *)country;

/// This method returns PlaceData for the place that has the given \c index
/// in the sorted list of places of the given \c country.
- (PlaceData *)placeDataForCountry:(NSString *)country atIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
