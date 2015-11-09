//
//  PlayingCard.m
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/3/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

-(instancetype) init {
  return nil;
}

-(instancetype) initWithSuit:(NSString *)suit andRank:(NSUInteger)rank{
  
  if (self = [super init]) {
    if ( (![[PlayingCard validSuits] containsObject:suit]) || (rank > [PlayingCard maxRank]) ) {
      return nil;
    }
    
    _suit = suit;
    _rank = rank;

  }
  
  return self;
}

+ (NSArray*) validSuits
{
  return @[@"♥", @"♦", @"♠", @"♣"];
}

+ (NSArray*) rankStrings
{
  return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

static const int RANK_BONUS = 4;
static const int SUIT_BONUS = 1;
//static const int MISMATCH_PENALTY = 1;

+ (NSUInteger) maxRank
{
  return [[PlayingCard rankStrings] count] - 1;
}

- (NSInteger) matched:(NSArray *)cards {
  NSInteger score = 0, matchingCount=0;;
  NSMutableArray * allCards = [[NSMutableArray alloc] initWithArray:cards];
  [allCards addObject:self];
  
  for (int i = 0; i < [allCards count]; i++) {
    for (int j = i+1; j < [allCards count]; j++) {
      PlayingCard *cardI = allCards[i], *cardJ = allCards[j];
      if (cardI.rank == cardJ.rank) {
        score += RANK_BONUS;
        matchingCount++;
      }
      else if (cardI.suit == cardJ.suit) {
        score += SUIT_BONUS;
        matchingCount++;
      }
    }
  }
  
  float scoreFactor = (matchingCount*matchingCount+1)/((float)[cards count]+1);
  return score * ((scoreFactor < 1)? 1 : (NSInteger)scoreFactor);
}

- (NSString*)suit
{
  return _suit ? _suit : @"?";
}

- (NSString*) contents
{
  NSArray *ranks = [PlayingCard rankStrings];
  return [ ranks[self.rank] stringByAppendingString:self.suit ];
}



@end
