//
//  Card.m
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/3/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

- (NSInteger) matched:(NSArray *)cards
{
  int score = 0;
  for (Card *card in cards)
  {
    if ([self.contents isEqualToString:card.contents])
    {
      score += 1;
    }
  }
  return score;
}

@end
