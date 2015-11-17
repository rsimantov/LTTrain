//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/4/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardGame.h"
#import "Deck.h"

@interface CardMatchingGame : CardGame

- (instancetype)init NS_UNAVAILABLE;

// Designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                         fromDeck:(Deck*)deck
           withCardMatchingNumber:(NSUInteger)matchingNumber NS_DESIGNATED_INITIALIZER;

@end
