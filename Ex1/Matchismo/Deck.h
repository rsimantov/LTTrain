//
//  Deck.h
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/3/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"

@interface Deck : NSObject
	
- (void) addCard:(Card*)card atTop:(BOOL)atTop;
- (void) addCard:(Card*)card;

- (Card*) drawRandomCard;

@end
