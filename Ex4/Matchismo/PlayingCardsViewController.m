//
//  PlayingCardsViewController.m
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/10/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import "PlayingCardsViewController.h"

#import "CardMatchingGame.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"

static const int INITIAL_CARDS_COUNT = 30;
static const int MINIMUM_TOTAL_CARDS_COUNT = 30;
static const float CARDS_ASPECT_RATIO = (float)(40.0/60.0);

@interface PlayingCardsViewController ()
@property (weak, nonatomic) IBOutlet UIView *cardsView;
@end

@implementation PlayingCardsViewController

- (CardGame *)createGame {
  return [[CardMatchingGame alloc] initWithCardCount:INITIAL_CARDS_COUNT
                                            fromDeck:[[PlayingCardDeck alloc] init]
                              withCardMatchingNumber:2];
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

- (CardView *)createCardViewFromCard:(Card *)card andFrame:(CGRect)frame {
  if (![card isKindOfClass:[PlayingCard class]]) {
    return nil;
  }
  PlayingCard *playingCard = (PlayingCard *)card;
  return [[PlayingCardView alloc] initWithFrame:frame
                                  andRank:playingCard.rank
                                  andSuit:playingCard.suit
                                  andFaceUp:playingCard.chosen];
}

- (void)updateCardView:(CardView *)cardView fromCard:(Card *)card {
  ((PlayingCardView *)cardView).faceUp = card.isChosen;
}

@end
