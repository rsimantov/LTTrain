//
//  CardGame.m
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/11/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import "CardGame.h"

@interface CardGame ()

// protected
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSString *log;

@end

@implementation CardGame

- (void)selectCardAtIndex:(NSUInteger)index { //abstract
  return;
}

- (Card *)cardAtindex:(NSUInteger)index { // abstract
  return nil;
}

- (NSArray *)logEntries { // abstract
  return nil;
}

@end
