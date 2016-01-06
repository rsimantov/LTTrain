// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Reuven Siman Tov.

#import <Foundation/Foundation.h>

#import "PhotoData.h"

@protocol TimelineSearch <NSObject>

- (NSString *)webCommand;
- (NSArray<PhotoData *> *)filter:(NSArray<PhotoData *> *);

@end

