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

// protected
- (void)selectCardAtIndex:(NSUInteger)index; //abstract
- (Card *)cardAtindex:(NSUInteger)index; //abstract
- (NSArray *)logEntries; //abstract

@property (nonatomic, readonly) NSInteger score;

@end
