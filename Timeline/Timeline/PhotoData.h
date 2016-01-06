// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Reuven Siman Tov.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoData : NSObject

@property (strong, nonatomic) NSURL *mediaLocation;
@property (nonatomic) NSUInteger ID;
@property (nonatomic) NSUInteger mediaType;
@property (nonatomic) NSUInteger ownerID;
@property (strong, nonatomic) NSString *Title;
@property (strong, nonatomic) NSString *Desc;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSArray *tags; // of NSString
@property (strong, nonatomic) NSUInteger likes;
@property (strong, nonatomic) NSUInteger unlikes;
@property (strong, nonatomic) NSUInteger visibility;

@end

NS_ASSUME_NONNULL_END
