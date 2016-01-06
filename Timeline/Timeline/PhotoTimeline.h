// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Reuven Siman Tov.

#import <Foundation/Foundation.h>

#import "TimelineSearch.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoTimeline : NSObject

- (void) photosDataForSearch:(id<TimelineSearch>)search
                  completion:(void(^)((NSArray<PhotoData *> *) photosData,
                                      NSError *error))completion;

- (void)localThumbLocationForPhoto:(PhotoData *)photoData
                        completion:(void(^)((NSURL *)thumbLocation, NSError *error))completion;

- (void)localPhotoLocationForPhoto:(PhotoData *)photoData
                        completion:(void(^)((NSURL *)photoLocation, NSError *error))completion;

- (void)sharePhoto:(PhotoData *)photoData completion:(void(^)(NSError *error))completion;

- (void)deletePhoto:(PhotoData *)photoData completion:(void(^)(NSError *error))completion;

- (void)updatePhoto:(PhotoUpdateTask *)photoUpdate completion:(void(^)(NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
