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

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipsCount;
@property (strong, nonatomic) Deck *deck;

@end

@implementation ViewController

- (Deck *)deck
{
  if (!_deck)
    _deck = [[PlayingCardDeck alloc] init];
  return _deck;
}

- (void) setFlipsCount:(int)flipsCount
{
  _flipsCount = flipsCount;
  self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipsCount];
  NSLog(@"flipsCount changed to %d", self.flipsCount);
}

- (IBAction)touchCardButton:(UIButton *)sender {
  
  if ([sender.currentTitle length]) {
    // The front is being shown, flip to back.
    [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                      forState:UIControlStateNormal];
    [sender setTitle:@"" forState:UIControlStateNormal];
  }
  else
  {
    // The back is being shown, drawing a card an showing it.
    Card *card = [self.deck drawRandomCard];
    [sender setBackgroundImage:card ? [UIImage imageNamed:@"cardfront"] : nil
                      forState:UIControlStateNormal];
    [sender setTitle:[card contents] forState:UIControlStateNormal];
    if (card) self.flipsCount++;
  }
}

@end
