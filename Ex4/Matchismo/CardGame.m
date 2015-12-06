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

- (NSInteger)drawCard { //abstract
  return -1;
}

- (NSUInteger)cardsCount { //abstract
  return 0;
}

- (void)selectCardAtIndex:(NSUInteger)index { //abstract
  return;
}

- (Card *)cardAtIndex:(NSUInteger)index { // abstract
  return nil;
}

@end
