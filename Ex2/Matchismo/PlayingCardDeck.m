//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/3/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

-(instancetype)init
{
  if (self = [super init])
  {
    for (NSString *suit in [PlayingCard validSuits]) {
      for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
        PlayingCard *card = [[PlayingCard alloc] initWithSuit:suit andRank:rank];
        [self addCard:card];
      }
    }
  }
  
  return self;
}

@end
