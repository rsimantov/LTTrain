//
//  LogEntry.h
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/17/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface LogEntry : NSObject

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithText:(NSString *)text andCards:(NSArray *)cards  NS_DESIGNATED_INITIALIZER;

@property (strong, nonatomic, readonly) NSString *text;
@property (strong, nonatomic, readonly) NSArray *cards;

@end
