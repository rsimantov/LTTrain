//
//  PlayingCardView.h
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/18/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"

@interface PlayingCardView : CardView

- (id)initWithFrame:(CGRect)frame
            andRank:(NSUInteger)rank
            andSuit:(NSString *)suit
          andFaceUp:(BOOL)faceUp;

@property (nonatomic, readonly) NSUInteger rank;
@property (strong, nonatomic, readonly) NSString *suit;
@property (nonatomic) BOOL faceUp;

@end
