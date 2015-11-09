//
//  ViewController.m
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/2/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import "ViewController.h"

#import "Card.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeControl;
@property (weak, nonatomic) IBOutlet UILabel *logLabel;
@end

@implementation ViewController

- (CardMatchingGame *)game {
  if (!_game) {
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                               fromDeck:[[PlayingCardDeck alloc] init]
                                 withCardMatchingNumber:self.cardMatchingNumber];
  }
  return _game;
}

- (IBAction)touchCardButton:(UIButton *)sender {
  NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
  [self.game flipCardAtIndex:chosenButtonIndex];
  self.matchModeControl.enabled = NO;
  [self updateUI];
}

- (NSUInteger)cardMatchingNumber {
  return self.matchModeControl.selectedSegmentIndex + 2;
}

- (IBAction)selectMatchModeControl:(UISegmentedControl *)sender {
  self.game = nil;
}

- (IBAction)touchReDealButton:(UIButton *)sender {
  self.game = nil;

  self.matchModeControl.enabled = YES;
  self.matchModeControl.selectedSegmentIndex = 0;
  [self updateUI];
}

- (void)updateUI {
  [self updateCardsUI];
  [self updateScoreLabel];
  [self updateLogLabel];
}

- (void)updateScoreLabel {
  [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %ld",self.game.score]];
}

- (void)updateLogLabel {
  self.logLabel.text = self.game.log;
}

- (void)updateCardsUI {
  
  for (NSUInteger i = 0; i < [self.cardButtons count]; i++) {
    Card *card = [self.game cardAtindex:i];
    UIButton *button = self.cardButtons[i];
    if (card.isChosen) {
      [button setTitle:card.contents forState:UIControlStateNormal];
      [button setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
      if (card.isMatched) {
        button.enabled = NO;
      }
    }
    else {
      [button setTitle:@"" forState:UIControlStateNormal];
      [button setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
      button.enabled = YES;
    }
  }
}

@end
