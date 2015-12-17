// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Reuven Siman Tov.

#import "PlaceData.h"

NS_ASSUME_NONNULL_BEGIN

/// Object that contains place's data such as ID, name, region and country.
@interface PlaceData : NSObject

- (instancetype)init NS_UNAVAILABLE;

/// Contructor that returns PlaceData with the given \c placeId, \c placeName,
/// \c regionName and \c countryName.
- (instancetype)initWithPlaceId:(NSString *)placeId
                      placeName:(NSString *)placeName
                     regionName:(NSString *)regionName
                 andCountryName:(NSString *)countryName NS_DESIGNATED_INITIALIZER;

/// The place's ID.
@property (strong, readonly, nonatomic) NSString *placeId;

/// The place's name.
@property (strong, readonly, nonatomic) NSString *placeName;

/// The place's region name.
@property (strong, readonly, nonatomic) NSString *regionName;

/// The place's country name.
@property (strong, readonly, nonatomic) NSString *countryName;

@end

NS_ASSUME_NONNULL_END
