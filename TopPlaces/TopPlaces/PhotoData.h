// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Reuven Siman Tov.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Object that contains photos's data such as URL, title, and description.
@interface PhotoData : NSObject

- (instancetype)init NS_UNAVAILABLE;

/// Contructor that returns PhotoData with the given \c photoURL, \c photoTitle
/// and \c photoDescription.
- (instancetype)initWithPhotoURL:(NSURL *)photoURL
                      photoTitle:(NSString *)photoTitle
                photoDescription:(NSString *)photoDescription NS_DESIGNATED_INITIALIZER;

/// The photo's URL.
@property (strong, readonly, nonatomic) NSURL *photoURL;

/// The photo's title.
@property (strong, readonly, nonatomic) NSString *photoTitle;

/// The photo's description.
@property (strong, readonly, nonatomic) NSString *photoDescription;

@end

NS_ASSUME_NONNULL_END
