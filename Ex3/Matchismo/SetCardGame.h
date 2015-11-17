//
//  SetCardGame.h
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/12/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import "CardGame.h"

@interface SetCardGame : CardGame

- (instancetype)init NS_UNAVAILABLE;

// Designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count NS_DESIGNATED_INITIALIZER;

@end
