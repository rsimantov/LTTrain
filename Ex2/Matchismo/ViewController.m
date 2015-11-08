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
                                               fromDeck:[[PlayingCardDeck alloc] init]];
  }
  return _game;
}

- (IBAction)touchCardButton:(UIButton *)sender {
  NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
  [self.game flipCardAtIndex:chosenButtonIndex];
  [self.matchModeControl setEnabled:NO];
  [self updateUI];
}

- (IBAction)selectMatchModeControl:(UISegmentedControl *)sender {
  NSInteger index = [sender selectedSegmentIndex];
  switch (index) {
    case 0:
      self.game.matchMode = CardMatchingMode2;
      break;
    case 1:
      self.game.matchMode = CardMatchingMode3;
      break;
    default:
      // assert
      NSLog(@"selectMatchModeControl: bad control index = %ld", index);
      break;
  }
}

- (IBAction)touchReDealButton:(UIButton *)sender {
  self.game = nil;

  [self.matchModeControl setEnabled:YES];
  [self.matchModeControl setSelectedSegmentIndex:0];
  [self updateUI];
}

- (void)updateUI {
  for (NSUInteger i = 0; i < [self.cardButtons count]; i++) {
    Card *card = [self.game cardAtindex:i];
    UIButton *button = self.cardButtons[i];
    if (card.isChosen) {
      [button setTitle:card.contents forState:UIControlStateNormal];
      [button setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
      if (card.isMatched) {
        [button setEnabled:NO];
      }
    }
    else {
      [button setTitle:@"" forState:UIControlStateNormal];
      [button setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
      [button setEnabled:YES];
    }
  }
  [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %ld",self.game.score]];
  [self.logLabel setText:self.game.log];
}

@end
