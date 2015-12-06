//
//  SetViewController.m
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/10/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import "SetViewController.h"

#import "Grid.h"
#import "SetCard.h"
#import "SetCardGame.h"
#import "SetCardView.h"
#import "SetDeck.h"

static const int CARDS_PER_DRAW_REQUEST = 3;
static const int INITIAL_CARDS_COUNT = 12;
static const int MINIMUM_TOTAL_CARDS_COUNT = 30;
static const float CARDS_ASPECT_RATIO = (float)(40.0/60.0);

@interface SetViewController ()
@property (weak, nonatomic) IBOutlet UIView *cardsView;
@end

@implementation SetViewController

- (CardGame *)createGame {
  CardGame *game = [[SetCardGame alloc] initWithCardCount:INITIAL_CARDS_COUNT
                                                 fromDeck:[[SetDeck alloc] init]];
  return game;
}

- (Grid *)createCardsGrid {
  Grid * cardsGrid = [[Grid alloc] init];
  cardsGrid.size = self.cardsView.frame.size;
  cardsGrid.cellAspectRatio = CARDS_ASPECT_RATIO;
  cardsGrid.minimumNumberOfCells =  MINIMUM_TOTAL_CARDS_COUNT;
  if (!cardsGrid.inputsAreValid) {
    return nil;
  }
  return cardsGrid;
}

- (UIView *)fetchCardsView {
  return self.cardsView;
}

- (IBAction)drawCardsButtonTouched:(id)sender {
  [self drawCards:CARDS_PER_DRAW_REQUEST];
}

- (CardView *)createCardViewFromCard:(Card *)card andFrame:(CGRect)frame {
  if (![card isKindOfClass:[SetCard class]]) {
    return nil;
  }
  SetCard *setCard = (SetCard *)card;
  return [[SetCardView alloc] initWithFrame:frame
                                  andSymbol:setCard.symbol
                                  andNumber:setCard.number
                                 andShading:setCard.shading
                                   andColor:setCard.color
                                  andChosen:setCard.chosen];
}

- (void)updateCardView:(CardView *)cardView fromCard:(Card *)card {
  ((SetCardView *)cardView).chosen = card.isChosen;
}

@end
