//
//  PlayingCardView.m
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/18/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import "PlayingCardView.h"

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

@interface PlayingCardView()
@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@end

@implementation PlayingCardView

- (id)initWithFrame:(CGRect)frame
            andRank:(NSUInteger)rank
            andSuit:(NSString *)suit
          andFaceUp:(BOOL)faceUp {
  
  if (self = [super initWithFrame:frame]) {
    
    if ((![self validRank:rank]) || (![self validSuits:suit])) {
      return self;
    }
    _rank = rank;
    _suit = suit;
    _faceUp = faceUp;
    [self setup];
  }
  return self;
}

- (void)setup {
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib {
  [self setup];
}

- (void)drawRect:(CGRect)rect {
  [self drawBackground];
  if (self.faceUp) {
    [self drawCorners];
  }
  else {
    [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
  }
}

- (void)drawBackground {
  UIBezierPath *roundedRect =
      [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRaduis]];
  [roundedRect addClip];
  [[UIColor whiteColor] setFill];
  [roundedRect fill];
  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
}

- (void)drawCorners {
  NSAttributedString *text = [self cornerText];
  CGRect textBounds;

  // Upper left
  textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
  textBounds.size = [text size];
  [text drawInRect:textBounds];
  
  // Bottom right
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
  CGContextRotateCTM(context, M_PI);
  [text drawInRect:textBounds];
}

- (NSAttributedString *)cornerText {
  NSMutableParagraphStyle *pStyle = [[NSMutableParagraphStyle alloc] init];
  pStyle.alignment = NSTextAlignmentCenter;
  UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  font = [font fontWithSize:font.pointSize * [self cornerScaleFactor] * 2];
  NSAttributedString *text =
  [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",
                                              [self rankStrings][self.rank],
                                              self.suit]
                                  attributes:@{NSFontAttributeName : font,
                                               NSParagraphStyleAttributeName : pStyle}];
  return text;
}

- (BOOL)validRank:(NSUInteger)rank {
  return (rank > 0) && (rank <=  [self maxRank]);
}

- (BOOL) validSuits:(NSString*)suit{
  for (NSString *validSuit in @[@"♥", @"♦", @"♠", @"♣"]) {
    if ([validSuit isEqualToString:suit]) {
      return YES;
    }
  }
  return NO;
}

- (NSArray *)rankStrings {
  return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

- (NSUInteger)maxRank
{
  return [[self rankStrings] count] - 1;
}

- (void)setFaceUp:(BOOL)faceUp {
  if (_faceUp != faceUp) {
    [UIView transitionWithView:self
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                      _faceUp = faceUp;
                      [self setNeedsDisplay];}
                    completion:nil];

  }
}

- (CGFloat)cornerScaleFactor {
  return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT;
}

- (CGFloat)cornerRaduis {
  return CORNER_RADIUS * [self cornerScaleFactor];
}

- (CGFloat)cornerOffset {
  return [self cornerRaduis] / 3.0;
}

@end
