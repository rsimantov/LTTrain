//
//  SetCard.m
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/12/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (instancetype)init {
  return nil;
}

- (instancetype)initWithSymbol:(SetCardSymbol)symbol
                     andNumber:(NSUInteger)number
                    andShading:(SetCardShading)shading
                      andColor:(SetCardColor)color {
  
  if (self = [super init]) {
    
    if (symbol > SetCardSymbolMax || symbol < SetCardSymbolMin ||
        number > 3 || number < 1 ||
        shading > SetCardShadingMax || shading < SetCardShadingMin ||
        shading > SetCardColorMax || shading < SetCardColorMin) {
      return nil;
    }
    _symbol = symbol;
    _number = number;
    _shading = shading;
    _color = color;
  }
  return self;
}

- (NSInteger) matched:(NSArray *)cards {

  if ([cards count] != 2 ||
      (![cards[0] isKindOfClass:[SetCard class]]) ||
      (![cards[1] isKindOfClass:[SetCard class]])) {
    return 0;
  }

  return [self matchedCard:(SetCard *)cards[0] andCard:(SetCard *)cards[1]];
}

- (NSInteger) matchedCard:(SetCard *)card1 andCard:(SetCard *)card2 {
  
  if (((card1.symbol + card2.symbol + self.symbol) % 3) ||
      ((card1.number + card2.number + self.number) % 3) ||
      ((card1.shading + card2.shading + self.shading) % 3) ||
      ((card1.color + card2.color + self.color) % 3)) {
    return 0;
  }
  return 1;
}

- (NSString*) contents
{
  return [NSString stringWithFormat:@"%lu%lu%lu%lu", self.symbol, self.number, self.shading, self.color];
}


@end
