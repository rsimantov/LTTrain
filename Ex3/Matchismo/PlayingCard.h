//
//  PlayingCard.h
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/3/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

-(instancetype) init NS_UNAVAILABLE;

// Designated initializer
-(instancetype) initWithSuit:(NSString *)suit andRank:(NSUInteger)rank NS_DESIGNATED_INITIALIZER;

+ (NSArray*) validSuits;
+ (NSArray*) rankStrings;
+ (NSUInteger) maxRank;

@property (strong, nonatomic, readonly) NSString *suit;
@property (nonatomic, readonly) NSUInteger  rank;

@end
