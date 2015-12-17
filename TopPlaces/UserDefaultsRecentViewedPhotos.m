// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by rsimantov.

#import "UserDefaultsRecentViewedPhotos.h"

NS_ASSUME_NONNULL_BEGIN

static const int kURLIndex = 0;
static const int kTitleIndex = 1;
static const int kDescriptionIndex = 2;
static const int kMaxPhotos = 20;
static const char * kDefaultsEntryName = "TopPlaces";

@interface UserDefaultsRecentViewedPhotos ()

// Constractor that returns UserDefaultsRecentViewedPhotos object with maximum number
// of \c maxPhotos photos.
- (instancetype)initWithMaxPhotos:(NSUInteger)maxPhotos NS_DESIGNATED_INITIALIZER;

@property (nonatomic) NSUInteger maxPhotos;
@property (strong, nonatomic) NSMutableArray *recentPhotosUpdatedDelegates;

@end

@implementation UserDefaultsRecentViewedPhotos

- (instancetype)initWithMaxPhotos:(NSUInteger)maxPhotos {
  if (self = [super init]) {
    self.maxPhotos = maxPhotos;
  }
  return self;
}

+ (UserDefaultsRecentViewedPhotos *)sharedUserDefaultsRecentViewedPhotos {
  static UserDefaultsRecentViewedPhotos *sharedInstance = nil;
  if (!sharedInstance) {
    sharedInstance = [[UserDefaultsRecentViewedPhotos alloc] initWithMaxPhotos:kMaxPhotos];
  }
  return sharedInstance;
}

#pragma mark -
#pragma mark Loadable
#pragma mark -

- (void)load {
  return;
}

#pragma mark -
#pragma mark PhotosList
#pragma mark -

- (NSUInteger)photosCount {
  return [[self userDefaults] count];
}

- (PhotoData *)photoData:(NSUInteger)index {
  NSAssert2(index < [self photosCount],
            @"index is %ld while photos count is %ld", index, [self photosCount]);
  NSArray *entry = [self userDefaults][[self photosCount]-index-1];
  return [[PhotoData alloc] initWithPhotoURL:[NSURL URLWithString:entry[kURLIndex]]
                                  photoTitle:entry[kTitleIndex]
                            photoDescription:entry[kDescriptionIndex]];
}

#pragma mark -
#pragma mark RecentViewedPhotosHandler
#pragma mark -

- (void)addPhotoData:(PhotoData *)photoData {
  if (!photoData.photoURL) {
    return; // Just ignoring this photoData.
  }
  NSString *urlString = [photoData.photoURL absoluteString];
  NSMutableArray *defaults = [NSMutableArray arrayWithArray:[self userDefaults]];
  [defaults filterUsingPredicate:[NSPredicate predicateWithBlock:
                                  ^BOOL(id evaluatedObject, NSDictionary *bindings) {
                                    return ![urlString isEqual:evaluatedObject];
                                  }]];
  [defaults addObject:@[urlString, photoData.photoTitle, photoData.photoDescription]];
  if ([defaults count] > self.maxPhotos) {
    [defaults removeObjectAtIndex:0];
  }
  [self setUserDefaults:[defaults mutableCopy]];
  [self.recentPhotosUpdatedDelegates
      makeObjectsPerformSelector:@selector(recentViewedPhotosUpdated)];
}

- (NSArray *)userDefaults {
  return [[NSUserDefaults standardUserDefaults]
          objectForKey:[NSString stringWithUTF8String:kDefaultsEntryName]];
  
}

- (void)setUserDefaults:(NSArray *)defaults {
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  [userDefaults setObject:defaults forKey:[NSString stringWithUTF8String:kDefaultsEntryName]];
  [userDefaults synchronize];
}

- (void)addRecentPhotosViewedUpdatedDelegate:(id<RecentViewedPhotosUpdatedDelegate>)delegate {
  if (![self.recentPhotosUpdatedDelegates containsObject:delegate]) {
    [self.recentPhotosUpdatedDelegates addObject:delegate];
  }
}

#pragma mark -
#pragma mark Properties
#pragma mark -

- (NSMutableArray *)recentPhotosUpdatedDelegates {
  if (!_recentPhotosUpdatedDelegates) {
    _recentPhotosUpdatedDelegates = [[NSMutableArray alloc] init];
  }
  return _recentPhotosUpdatedDelegates;
}

@end

NS_ASSUME_NONNULL_END
