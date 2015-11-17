//
//  SetCardGame.m
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/12/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import "SetCardGame.h"
#import "LogEntry.h"
#import "SetDeck.h"

@interface CardGame ()
@property (nonatomic, readwrite) NSInteger score;

@end

@interface SetCardGame ()
@property (nonatomic, strong) NSMutableArray *cards; // of card
@property (nonatomic, readwrite) NSMutableArray *log;
@end

@implementation SetCardGame

-(instancetype) init {
  return nil;
}

-(instancetype) initWithCardCount:(NSUInteger)count {
  
  if (self = [super init]) {
    SetDeck *deck = [[SetDeck alloc] init];
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
  }
  return self;
}

- (Card *) cardAtindex:(NSUInteger)index {
  return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = -2;
static const int MATCH_BOUNS = 4;

// selectCardAtIndex
- (void)selectCardAtIndex:(NSUInteger)index {
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
  [self addLogEntryForScore:score andCards:chosenCards];
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

- (void)addLogEntryForScore:(NSInteger)score andCards:(NSArray *)cards {
  LogEntry *entry;
  if (score > 0) {
    NSString *text = [NSString stringWithFormat:@"matched for %ld points.", score];
    entry = [[LogEntry alloc] initWithText:text andCards:cards];
  }
  else {
    NSString *text = [NSString stringWithFormat:@"don't match! %ld points penalty!", score];
    entry = [[LogEntry alloc] initWithText:text andCards:cards];
  }
  [self.log addObject:entry];
}

- (NSMutableArray *)cards {
  if (!_cards) {
    _cards = [[NSMutableArray alloc] init];
  }
  return _cards;
}

- (NSMutableArray *)log {
  if (!_log) {
    _log = [[NSMutableArray alloc] init];
  }
  return _log;
}

- (NSArray *)logEntries {
  return self.log;
}

@end
