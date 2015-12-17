// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by rsimantov.

#import "FlickrPlacesList.h"

#import "FlickrFetcher/FlickrFetcher.h"

NS_ASSUME_NONNULL_BEGIN

@interface FlickrPlacesList ()
@property (strong, nonatomic, nullable) NSMutableDictionary *places;
@property (strong, nonatomic) NSURL *url;
@end

@implementation FlickrPlacesList

- (instancetype)initWithURL:(NSURL *)url {
  if (self = [super init]) {
    self.url = url;
  }
  return self;
}

#pragma mark -
#pragma mark Loadable
#pragma mark -

- (void)load {
  self.places = nil;
  NSData *jsonResults = [NSData dataWithContentsOfURL:self.url];
  NSDictionary *propertyList = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                               options:0
                                                                 error:NULL];
  NSArray *places = [propertyList valueForKeyPath:FLICKR_RESULTS_PLACES];
  NSArray *countriesList = [self countriesList:places];
  for (NSString *country in countriesList) {
    [self.places setObject:[self sortedPlacesForCountry:country fromPlaces:places]
                    forKey:country];
  }
}

- (NSArray *)countriesList:(NSArray *)places {
  NSArray *placesContent =  [places valueForKeyPath:FLICKR_PLACE_NAME];
  NSMutableArray *countriesList = [[NSMutableArray alloc] init];
  for (NSString *content in placesContent) {
    [countriesList addObject:[self countryName:content]];
  }
  return [countriesList valueForKeyPath:@"@distinctUnionOfObjects.self"];
}

- (NSArray *)sortedPlacesForCountry:(NSString *)country
                  fromPlaces:(NSArray *)places {
  NSPredicate *predicate =
      [NSPredicate predicateWithFormat:@"%K ENDSWITH[cd] %@", FLICKR_PLACE_NAME, country];
  return [[places filteredArrayUsingPredicate:predicate]
          sortedArrayUsingComparator:
            ^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
              return [[obj1 valueForKey:FLICKR_PLACE_NAME]
                        compare:[obj1 valueForKey:FLICKR_PLACE_NAME]];
          }];
}

#pragma mark -
#pragma mark PlacesList
#pragma mark -

- (NSArray *)countries {
  return [self.places allKeys];
}

- (NSUInteger)placesCountForCountry:(NSString *)country {
  return [[self.places valueForKey:country] count];
}

- (PlaceData *)placeDataForCountry:(NSString *)country atIndex:(NSUInteger)index {
  NSDictionary *placeEntry = [self.places valueForKey:country][index];
  NSString * placeContent = [placeEntry valueForKey:FLICKR_PLACE_NAME];
  return [[PlaceData alloc] initWithPlaceId:[placeEntry valueForKey:FLICKR_PLACE_ID]
                                  placeName:[self placeName:placeContent]
                                 regionName:[self areaName:placeContent]
                             andCountryName:[self countryName:placeContent]];
}

- (NSString *)placeName:(NSString *)contentString {
  return [[contentString componentsSeparatedByString:@","][0]
          stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)areaName:(NSString *)contentString {
  return [[contentString componentsSeparatedByString:@","][1]
          stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)countryName:(NSString *)contentString {
  NSArray *terms = [contentString componentsSeparatedByString:@","];
  return [terms[[terms count]-1]
          stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

#pragma mark -
#pragma mark Properties
#pragma mark -

- (NSDictionary * _Nullable)places {
  if (!_places) {
    _places = [[NSMutableDictionary alloc] init];
  }
  return _places;
}

@end

NS_ASSUME_NONNULL_END
