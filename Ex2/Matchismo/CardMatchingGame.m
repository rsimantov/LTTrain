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

- (Card *) cardAtindex:(NSUInteger)index {
  return (index < [self.cards count]) ? self.cards[index] : nil;
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
  
  NSMutableArray *chosenCards = [self getChosenCards];

  if ([chosenCards count] == self.cardMatchingNumber - 1) {
    
    NSInteger score = [card matched:chosenCards];
    
    self.log = @"";
    [chosenCards addObject:card];
    [self handleChosenCards:chosenCards thatMatch:score>0];
    [self updateScore:score];
  }

  self.score -= CHOOSING_COST;
  card.chosen = YES;
}
- (void)handleChosenCards:(NSArray*)cards thatMatch:(BOOL)isMatch {
  for (Card *card in cards) {
    card.matched = isMatch;
    card.chosen = isMatch;
    self.log = [NSString stringWithFormat:@"%@%@ ", self.log, card.contents];
  }
}

- (void)updateScore:(NSInteger)score {
  if (score) {
    score *= MATCH_BOUNS;
    self.score += score;
    
    self.log = [NSString stringWithFormat:@"%@matched for %ld points.",
                self.log, score];
  }
  else {
    score -= MISMATCH_PENALTY;
    self.log = [NSString stringWithFormat:@"%@don't match! %d points penalty!",
                self.log, MISMATCH_PENALTY];
  }
}

- (NSMutableArray *)getChosenCards {
  NSPredicate *predicate =
      [NSPredicate	predicateWithFormat:@"isChosen == YES && matched == NO"];
  return [NSMutableArray 	arrayWithArray:[self.cards filteredArrayUsingPredicate:predicate]];
}

- (NSMutableArray *)cards {
  if (!_cards) {
    _cards = [[NSMutableArray alloc] init];
  }
  return _cards;
}


@end
