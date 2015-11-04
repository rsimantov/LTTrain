//
//  Deck.m
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/3/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import "Deck.h"

@interface Deck()

@property (strong, nonatomic) NSMutableArray *cards; // of Card

@end


@implementation Deck


- (void) addCard:(Card*)card atTop:(BOOL)atTop
{
  if (atTop)
  {
    [self.cards insertObject:card atIndex:0];
  }
  else
  {
    [self.cards addObject:card];
  }
}

- (void) addCard:(Card*)card
{
  [self addCard:card atTop:NO];
}

- (Card*) drawRandomCard
{
  Card *card = nil;
  
  if ([self.cards count])
  {
    unsigned index = arc4random() % [self.cards count];
    card = self.cards[index];
    [self.cards removeObjectAtIndex:index];
  }
  
  return card;
}

- (NSMutableArray*)cards
{
  if (!_cards)
    _cards = [[NSMutableArray alloc] init];
  return _cards;
}

@end
