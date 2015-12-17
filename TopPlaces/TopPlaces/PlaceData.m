// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Reuven Siman Tov.

#import <Foundation/Foundation.h>

#import "PlaceData.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaceData ()
@property (strong, readwrite, nonatomic) NSString *placeId;
@property (strong, readwrite, nonatomic) NSString *placeName;
@property (strong, readwrite, nonatomic) NSString *regionName;
@property (strong, readwrite, nonatomic) NSString *countryName;
@end

@implementation PlaceData

- (instancetype)initWithPlaceId:(NSString *)placeId
                      placeName:(NSString *)placeName
                     regionName:(NSString *)regionName
                 andCountryName:(NSString *)countryName {
  if (self = [super init]) {
    self.placeId = placeId;
    self.placeName = placeName;
    self.regionName = regionName;
    self.countryName = countryName;
  }
  return self;
}

@end

NS_ASSUME_NONNULL_END
