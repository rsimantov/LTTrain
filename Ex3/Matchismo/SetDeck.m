//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/12/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"

@implementation SetDeck

-(instancetype)init {

  if (self = [super init]) {
    for (SetCardSymbol symbol=SetCardSymbolMin; symbol<=SetCardSymbolMax; symbol++) {
      for (NSUInteger number = SET_CARD_NUMBER_MIN; number <= SET_CARD_NUMBER_MAX; number++) {
        for (SetCardShading shading = SetCardShadingMin; shading <= SetCardShadingMax; shading++) {
          for (SetCardColor color = SetCardColorMin; color <= SetCardColorMax; color++) {
            
            SetCard *card = [[SetCard alloc] initWithSymbol:symbol
                                                  andNumber:number
                                                 andShading:shading
                                                   andColor:color];
            [self addCard:card];
          }
        }
      }
    }
  }
  
  return self;
}

@end
