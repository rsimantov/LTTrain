//
//  SetViewController.m
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/10/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import "SetViewController.h"
#import "LogEntry.h"
#import "LogViewController.h"
#import "SetCard.h"
#import "SetCardGame.h"

@interface SetViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation SetViewController

- (CardGame *)createGame {
  return [[SetCardGame alloc] initWithCardCount:[self.cardButtons count]];
}

- (IBAction)touchCardButton:(UIButton *)sender {
  [super touchCardButton:sender];
}

- (NSArray *) gameCardButtons {
  return self.cardButtons;
}

- (void)updateCardsUI {
  
  for (NSUInteger i = 0; i < [[self gameCardButtons] count]; i++) {
    SetCard *card = (SetCard *)[self.game cardAtindex:i];
    UIButton *button = [self gameCardButtons][i];

    if (card.isMatched) {
      [self updateUIForMatchedCard:card andButton:button];
    }
    else if (card.isChosen) {
      [self updateUIForChosenCard:card andButton:button];
    }
    else {
      [self updateUIForUnChosenCard:card andButton:button];
    }
  }
}

- (void)updateUIForMatchedCard:(SetCard *)card andButton:(UIButton *)button {
  [button setAttributedTitle:[self attributedContentForCard:card]
                    forState:UIControlStateNormal];
  button.backgroundColor = [UIColor clearColor];
  button.enabled = NO;
}

- (void)updateUIForChosenCard:(SetCard *)card andButton:(UIButton *)button {
  [button setAttributedTitle:[self attributedContentForCard:card]
                    forState:UIControlStateNormal];
  button.backgroundColor = [UIColor lightGrayColor];
  button.enabled = YES;
}

- (void)updateUIForUnChosenCard:(SetCard *)card andButton:(UIButton *)button {
  [button setAttributedTitle:[self attributedContentForCard:card]
                    forState:UIControlStateNormal];
  button.backgroundColor = [UIColor whiteColor];
  button.enabled = YES;
}

- (NSAttributedString *)attributedContentForCard:(SetCard *)card {
  
  if (!card) {
    return nil;
  }

  NSMutableAttributedString *symbol =
      [[NSMutableAttributedString alloc] initWithString:[self stringSymbol:card.symbol]];
  symbol = [self addShading:card toText:symbol];
  
  NSMutableAttributedString *text =
      [[NSMutableAttributedString alloc]
       initWithString:[NSString stringWithFormat:@"%lu", card.number]];
  [text appendAttributedString:symbol];
  return [self addColor:card toText:text];
}

- (NSString *)stringSymbol:(SetCardSymbol)symbol {
  return @[@"▲", @"■", @"●"][symbol-SetCardSymbolMin];
}

- (NSMutableAttributedString *)addColor:(SetCard *)card
                                 toText:(NSMutableAttributedString *)text {
  UIColor *uiColor =
      @[[UIColor redColor], [UIColor greenColor], [UIColor purpleColor]][card.color-SetCardColorMin];
  [text addAttribute:NSForegroundColorAttributeName
               value:uiColor
               range:NSMakeRange(0, [text length])];
  return text;
}

- (NSMutableAttributedString *)addShading:(SetCard *)card toText:(NSMutableAttributedString *)text {
  NSDictionary *attributes = @{};
  if (card.shading == SetCardShadingOpen) {
    attributes = @{ NSStrokeWidthAttributeName : @10 };
  }
  else if (card.shading == SetCardShadingStripe) {
    attributes =
        @{ NSStrokeWidthAttributeName : @-10,
           NSStrokeColorAttributeName : [UIColor blackColor] } ;
  }
  [text addAttributes:attributes range:NSMakeRange(0, [text length])];
  return text;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if (![segue.identifier isEqualToString:@"showSetGameLog"]) {
    return;
  }
  if (![segue.destinationViewController isKindOfClass:[LogViewController class]]) {
    return;
  }
  LogViewController *logController = (LogViewController *)segue.destinationViewController;
  logController.logText = [self gameLog];
}

- (NSAttributedString *)gameLog {
  NSAttributedString *tab = [[NSAttributedString alloc] initWithString:@"\t"];
  NSAttributedString *newLine = [[NSAttributedString alloc] initWithString:@"\n"];
 
  NSMutableAttributedString *log = [[NSMutableAttributedString alloc] init];
  for (LogEntry *entry in [self.game logEntries]) {
    for (SetCard *card in entry.cards) {
      [log appendAttributedString:[self attributedContentForCard:card]];
      [log appendAttributedString:tab];
    }
    [log appendAttributedString:[[NSAttributedString alloc] initWithString:entry.text]];
    [log appendAttributedString:newLine];
  }
  return log;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateCardsUI];
}

@end
