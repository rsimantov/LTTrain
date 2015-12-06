//
//  SetCardView.h
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/18/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardView.h"

@interface SetCardView : CardView

- (id)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (id)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

// Designated initializer
- (id)initWithFrame:(CGRect)frame
          andSymbol:(NSUInteger)symbol
          andNumber:(NSUInteger)number
         andShading:(NSUInteger)shading
           andColor:(NSUInteger)color
          andChosen:(BOOL)chosen NS_DESIGNATED_INITIALIZER;

@property (nonatomic, readonly) NSUInteger symbol;
@property (nonatomic, readonly) NSUInteger number;
@property (nonatomic, readonly) NSUInteger shading;
@property (nonatomic, readonly) NSUInteger color;
@property (nonatomic) BOOL chosen;

@end
