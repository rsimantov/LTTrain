//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/4/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Deck.h"
#import "Card.h"

typedef NS_ENUM(NSInteger, CardMatchingMode) {
  CardMatchingModeDefault = 0,
  CardMatchingMode2 = CardMatchingModeDefault,
  CardMatchingMode3
};

@interface CardMatchingGame : NSObject

- (instancetype)init NS_UNAVAILABLE;

// Designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                         fromDeck:(Deck*)deck
           withCardMatchingNumber:(NSUInteger)matchingNumber NS_DESIGNATED_INITIALIZER;

- (void)flipCardAtIndex:(NSUInteger)index;
- (Card *)cardAtindex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) enum CardMatchingMode matchMode;
@property (nonatomic, readonly) NSString *log;

@end
