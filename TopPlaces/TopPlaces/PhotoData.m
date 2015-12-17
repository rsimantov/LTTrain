// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Reuven Siman Tov.

#import "PhotoData.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoData ()
@property (strong, readwrite, nonatomic) NSURL *photoURL;
@property (strong, readwrite, nonatomic) NSString *photoTitle;
@property (strong, readwrite, nonatomic) NSString *photoDescription;
@end

@implementation PhotoData

- (instancetype)initWithPhotoURL:(NSURL *)photoURL
                     photoTitle:(NSString *)photoTitle
               photoDescription:(NSString *)photoDescription {
  if (self = [super init]) {
    self.photoURL = photoURL;
    self.photoTitle = photoTitle;
    self.photoDescription = photoDescription;
  }
  return self;
}

@end

NS_ASSUME_NONNULL_END
