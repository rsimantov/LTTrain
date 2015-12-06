//
//  ViewController.h
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/2/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardGame.h"
#import "CardView.h"
#import "Grid.h"

@interface ViewController : UIViewController

- (void)drawCards:(NSUInteger)number;

// protected
- (CardGame *)createGame; //abstract
- (Grid *)createCardsGrid; //abstract
- (UIView *)fetchCardsView; //abstract
- (CardView *)createCardViewFromCard:(Card *)card andFrame:(CGRect)frame; //abstract
- (void)updateCardView:(CardView *)cardView fromCard:(Card *)card; // abstract
@end
