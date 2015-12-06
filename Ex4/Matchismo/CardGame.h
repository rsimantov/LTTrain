//
//  CardGame.h
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/11/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface CardGame : NSObject

- (NSInteger)drawCard; //abstract
- (NSUInteger)cardsCount; //abstract
- (void)selectCardAtIndex:(NSUInteger)index; //abstract
- (Card *)cardAtIndex:(NSUInteger)index; //abstract

@property (nonatomic, readonly) NSInteger score;

@end
