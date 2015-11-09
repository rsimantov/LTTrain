//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/4/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of card
@property (nonatomic, readwrite) NSString *log;
@property (nonatomic) NSUInteger cardMatchingNumber;
@end

@implementation CardMatchingGame

-(instancetype) init {
  return nil;
}

-(instancetype) initWithCardCount:(NSUInteger)count
                         fromDeck:(Deck *)deck
           withCardMatchingNumber:(NSUInteger)matchingNumber {

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

    if (matchingNumber < 2 || matchingNumber > count)
      return nil;
    self.cardMatchingNumber = matchingNumber;
  }
  return self;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BOUNS = 4;
static const int CHOOSING_COST = 1;

// flipCardAtIndex
- (void)flipCardAtIndex:(NSUInteger)index {
  Card *card = [self cardAtindex:index];
  
  if (!card) {
    // assert
    NSLog(@"nil card for index %ld", index);
    return;
  }
  
  if (card.isChosen) {
    if (!card.matched) {
      card.chosen = NO;
    }
    self.log = [NSString stringWithFormat:@"Flipped back %@.", card.contents];
    return;
  }
  
  self.log = [NSString stringWithFormat:@"%@ was chosen.", card.contents];
  
  NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
  
  for (Card *otherCard in self.cards) {
    if ( (!otherCard.isChosen) || (otherCard.matched) ) {
      continue;
    }
    [chosenCards addObject:otherCard];
  }

  NSUInteger chosenCount = [chosenCards count];
  if ( (self.matchMode == CardMatchingMode2 && chosenCount == 1) ||
       (self.matchMode == CardMatchingMode3 && chosenCount == 2)) {
    
    NSInteger score = [card matched:chosenCards];
    
    self.log = @"";
    
    if (score) {
      score *= MATCH_BOUNS;
      self.score += score;

      for (Card *otherCard in chosenCards) {
        otherCard.matched = YES;
        self.log = [NSString stringWithFormat:@"%@%@ ",
                     self.log, otherCard.contents];
      }
      card.matched = YES;
      
      self.log = [NSString stringWithFormat:@"%@and %@ matched for %ld points.",
                  self.log, card.contents, score];
    }
    else {
      score -= MISMATCH_PENALTY;
      for (Card *otherCard in chosenCards) {
        otherCard.chosen = NO; // flip back the other cards.
        self.log = [NSString stringWithFormat:@"%@%@ ",
                    self.log, otherCard.contents];
      }
      self.log = [NSString stringWithFormat:@"%@and %@ dont match! %d points penalty!",
                   self.log, card.contents, MISMATCH_PENALTY];
    }
  }

  self.score -= CHOOSING_COST;
  card.chosen = YES;
}

- (Card *) cardAtindex:(NSUInteger)index {
  return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (NSMutableArray *)cards {
  if (!_cards) {
    _cards = [[NSMutableArray alloc] init];
  }
  return _cards;
}


@end
