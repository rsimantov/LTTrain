//
//  SetCardGame.m
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/12/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import "SetCardGame.h"
#import "SetDeck.h"

@interface CardGame ()
@property (nonatomic, readwrite) NSInteger score;

@end

@interface SetCardGame ()
@property (nonatomic, strong) NSMutableArray *cards; // of card
@property (nonatomic, strong) Deck *deck;
@end

@implementation SetCardGame

-(instancetype) init {
  return nil;
}

-(instancetype) initWithCardCount:(NSUInteger)count fromDeck:(Deck*)deck {
  if (self = [super init]) {
    for (int i = 0; i < count; i++) {
      Card *card = [deck drawRandomCard];
      if (card) {
        [self.cards addObject:card];
      }
      else { // Abort
        self = nil;
        break;
      }
    }
    _deck = deck;
  }
  return self;
}

- (NSInteger)drawCard {
  Card *card = [self.deck drawRandomCard];
  if (card == nil) {
    return -1;
  }
  [self.cards addObject:card];
  return [self.cards count] -1;
}

- (NSUInteger)cardsCount {
  return [self.cards count];
}

- (Card *) cardAtIndex:(NSUInteger)index {
  return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = -2;
static const int MATCH_BOUNS = 4;

// selectCardAtIndex
- (void)selectCardAtIndex:(NSUInteger)index {
  Card *card = [self cardAtIndex:index];
  
  if (!card) {
    // assert
    NSLog(@"nil card for index %ld", index);
    return;
  }
  
  if (card.isChosen) {
    if (!card.matched) {
      card.chosen = NO;
    }
    return;
  }

  NSMutableArray *chosenCards = [self getChosenCards];
  
  if ([chosenCards count] == 2) {
    [self matchCards:chosenCards withCard:card];
  }
  else {
    card.chosen = YES;
  }
}

- (NSMutableArray *)getChosenCards {
  NSPredicate *predicate =
  [NSPredicate	predicateWithFormat:@"isChosen == YES && matched == NO"];
  return [NSMutableArray 	arrayWithArray:[self.cards filteredArrayUsingPredicate:predicate]];
}

- (void)matchCards:(NSMutableArray *)chosenCards withCard:(Card *)card {
  NSInteger score = [card matched:chosenCards];
  card.chosen = YES;
  
  [chosenCards addObject:card];
  [self handleChosenCards:chosenCards thatMatch:score>0];
  score = [self computeScore:score];
  self.score += score;
}

- (void)handleChosenCards:(NSArray*)cards thatMatch:(BOOL)isMatch {
  for (Card *card in cards) {
    card.matched = isMatch;
    card.chosen = isMatch;
  }
}

- (NSInteger)computeScore:(NSInteger)score {
  if (score) {
    return score * MATCH_BOUNS;
  }
  else {
    return MISMATCH_PENALTY;
  }
}

- (NSMutableArray *)cards {
  if (!_cards) {
    _cards = [[NSMutableArray alloc] init];
  }
  return _cards;
}

@end
