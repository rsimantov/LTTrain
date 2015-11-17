//
//  LogEntry.m
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/17/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import "LogEntry.h"

@implementation LogEntry


- (instancetype)init {
  return nil;
}

- (instancetype)initWithText:(NSString *)text andCards:(NSArray *)cards {
  if (self = [super init]) {
    _text = text;
    _cards = cards;
  }
  return self;
}

@end
