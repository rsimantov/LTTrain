//
//  PlayingCardsViewController.m
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/10/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import "PlayingCardsViewController.h"

#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "LogViewController.h"
#import "LogEntry.h"

@interface PlayingCardsViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation PlayingCardsViewController

- (CardGame *)createGame {
  return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                            fromDeck:[[PlayingCardDeck alloc] init]
                              withCardMatchingNumber:2];
}

- (IBAction)touchCardButton:(UIButton *)sender {
  [super touchCardButton:sender];
}

- (NSArray *) gameCardButtons { //abstract
  return self.cardButtons;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if (![segue.identifier isEqualToString:@"showPlayingCardGameLog"]) {
    return;
  }
  if (![segue.destinationViewController isKindOfClass:[LogViewController class]]) {
    return;
  }
  LogViewController *logController = (LogViewController *)segue.destinationViewController;
  logController.logText = [self gameLog];
}

- (NSAttributedString *)gameLog {
  NSMutableString *log = [[NSMutableString alloc] init];
  for (LogEntry *entry in [self.game logEntries]) {
    for (Card *card in entry.cards) {
      [log appendString:card.contents];
      [log appendString:@"\t"];
    }
    [log appendString:entry.text];
    [log appendString:@"\n"];
  }
  return [[NSAttributedString alloc] initWithString:log];
}

- (void)updateCardsUI {
  
  for (NSUInteger i = 0; i < [[self gameCardButtons] count]; i++) {
    Card *card = [self.game cardAtindex:i];
    UIButton *button = [self gameCardButtons][i];
    if (card.isChosen) {
      [self updateUIForMatchedCard:card andButton:button];
    }
    else if (card.isChosen) {
      [self updateUIForChosnCard:card andButton:button];
    }
    else {
      [self updateUIForUnChosenButton:button];
    }
  }
}

- (void)updateUIForMatchedCard:(Card *)card andButton:(UIButton *)button {
  [button setTitle:card.contents forState:UIControlStateNormal];
  [button setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
  button.enabled = NO;
}

- (void)updateUIForChosnCard:(Card *)card andButton:(UIButton *)button {
  [button setTitle:card.contents forState:UIControlStateNormal];
  [button setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
  button.enabled = YES;
}

- (void)updateUIForUnChosenButton:(UIButton *)button {
  [button setTitle:@"" forState:UIControlStateNormal];
  [button setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
  button.enabled = YES;
}

@end
