// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Reuven Siman Tov.

#import <Foundation/Foundation.h>

#import "PhotoData.h"

NS_ASSUME_NONNULL_BEGIN

@interface TimelineLocalCache : NSObject

- (instancetype)initWithURL:(NSURL *)url;

- (void)photosDataWithCompletion:(void(^)((NSArray<PhotoData *> *) photosData,
                                          NSError *error))completion;

- (void)addPhotoData:(PhotoData *)photoData completion:(void(^)(NSError *error))completion;

- (void)removePhotoData:(PhotoData *)photoData completion:(void(^)(NSError *error))completion;

- (void)addThumbForPhotoData:(PhotoData *)photoData fromLocation:(NSURL *)location
                  completion:(void(^)(NSError *error))completion;

- (void)addPhotoForPhotoData:(PhotoData *)photoData fromLocation:(NSURL *)location
                  completion:(void(^)(NSError *error))completion;

- (void)thumbLocationForPhotoData:(PhotoData *)photoData
                       completion:(void(^)((NSURL *)photoLocation, NSError *error))completion;

- (void)photoLocationForPhotoData:(PhotoData *)photoData
                       completion:(void(^)((NSURL *)photoLocation, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
