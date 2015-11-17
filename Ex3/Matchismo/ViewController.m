//
//  ViewController.m
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/2/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import "ViewController.h"
#import "Card.h"
#import "Deck.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic, readwrite) CardGame *game;
@end

@implementation ViewController

- (CardGame *) createGame { //abstract
  return nil;
}

- (NSArray *) gameCardButtons { //abstract
  return nil;
}

- (CardGame *)game {
  if (!_game) {
    _game = [self createGame];
  }
  return _game;
}

- (void)touchCardButton:(UIButton *)sender {
  NSUInteger chosenButtonIndex = [[self gameCardButtons] indexOfObject:sender];
  [self.game selectCardAtIndex:chosenButtonIndex];
  [self updateUI];
}

- (IBAction)touchReDealButton:(UIButton *)sender {
  self.game = nil;

  [self updateUI];
}

- (void)updateUI {
  [self updateCardsUI];
  [self updateScoreLabel];
}

- (void)updateScoreLabel {
  [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %ld",self.game.score]];
}

- (void)updateCardsUI {
  return;
}

@end
