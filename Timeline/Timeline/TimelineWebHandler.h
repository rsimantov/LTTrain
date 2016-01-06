// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Reuven Siman Tov.

#import <Foundation/Foundation.h>

#import "TimelineSearch.h"


NS_ASSUME_NONNULL_BEGIN

@interface TimelineWebHandler : NSObject

- (instancetype)initWithURL:(NSURL*)url;

- (void) photosDataForSearch:(id<TimelineSearch>)search
                  completion:(void(^)((NSArray<PhotoData *> *) photosData,
                                      NSError *error))completion;

- (void)sharePhoto:(PhotoData *)photoData fromLocation:(NSURL *)location
        completion:(void(^)(NSError *error))completion;

- (void)updatePhoto:(PhotoUpdateTask *)updateTask completion:(void(^)(NSError *error))completion;

- (void)fetchThumbForPhotoData:(PhotoData *)photoData
                    completion:(void(^)((NSURL *) thumbLocation, NSError *error))completion;

- (void)fetchPhotoForPhotoData:(PhotoData *)photoData
                    completion:(void(^)((NSURL *) thumbLocation, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
