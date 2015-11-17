//
//  SetCard.h
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/12/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import "Card.h"

#define SET_CARD_NUMBER_MIN (1)
#define SET_CARD_NUMBER_MAX (3)

typedef NS_ENUM(NSUInteger, SetCardSymbol) {
  SetCardSymbolMin = 1,
  SetCardSymbolDiamond = SetCardSymbolMin,
  SetCardSymbolSquiggle,
  SetCardSymbolOval,
  SetCardSymbolMax = SetCardSymbolOval
};

typedef NS_ENUM(NSUInteger, SetCardShading) {
  SetCardShadingMin = 1,
  SetCardShadingSolid = SetCardShadingMin,
  SetCardShadingStripe,
  SetCardShadingOpen,
  SetCardShadingMax = SetCardShadingOpen
};

typedef NS_ENUM(NSUInteger, SetCardColor) {
  SetCardColorMin = 1,
  SetCardColorRed = SetCardColorMin,
  SetCardColorGreen,
  SetCardColorPurple,
  SetCardColorMax = SetCardColorPurple
};

@interface SetCard : Card

- (instancetype)init NS_UNAVAILABLE;

// Designated initializer
- (instancetype)initWithSymbol:(SetCardSymbol)symbol
                     andNumber:(NSUInteger)number
                    andShading:(SetCardShading)shading
                      andColor:(SetCardColor)color NS_DESIGNATED_INITIALIZER;

@property (nonatomic, readonly) SetCardSymbol symbol;
@property (nonatomic, readonly) NSUInteger  number;
@property (nonatomic, readonly) SetCardShading shading;
@property (nonatomic, readonly) SetCardColor  color;

@end
