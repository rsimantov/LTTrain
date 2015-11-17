//
//  ViewController.h
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/2/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardGame.h"

@interface ViewController : UIViewController

@property (strong, nonatomic, readonly) CardGame *game;

- (void)touchCardButton:(UIButton *)sender;

// protected
- (CardGame *) createGame; //abstract
- (NSArray *) gameCardButtons; //abstract
- (void) updateCardsUI; // abstract
@end
