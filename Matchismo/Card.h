//
//  Card.h
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/3/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

- (int) matched:(NSArray *)cards;

@property (strong, nonatomic) 	NSString *contents;
@property (nonatomic, getter=isChosen ) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

@end
