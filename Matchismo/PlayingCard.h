//
//  PlayingCard.h
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/3/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

+ (NSArray*) validSuits;
+ (NSArray*) rankStrings;
+ (NSInteger) maxRank;

@property (strong, nonatomic)   NSString    *suit;
@property (nonatomic)           NSUInteger  rank;

@end
