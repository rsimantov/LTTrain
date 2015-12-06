//
//  SetCardView.m
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/18/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import "SetCardView.h"

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

@interface SetCardView()

@property (nonatomic) NSUInteger symbol;
@property (nonatomic) NSUInteger number;
@property (nonatomic) NSUInteger shading;
@property (nonatomic) NSUInteger color;
@end

@implementation SetCardView

- (id)initWithFrame:(CGRect)frame
          andSymbol:(NSUInteger)symbol
          andNumber:(NSUInteger)number
         andShading:(NSUInteger)shading
           andColor:(NSUInteger)color
          andChosen:(BOOL)chosen {
  if (self = [super initWithFrame:frame]) {
    _symbol = symbol;
    _number = number;
    _shading = shading;
    _color = color;
    _chosen = chosen;
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
  [self drawForeground];
}

- (void)drawBackground {
  UIBezierPath *roundedRect =
      [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRaduis]];
  [roundedRect addClip];
  if (self.chosen) {
    [[UIColor lightGrayColor] setFill];
  }
  else {
    [[UIColor whiteColor] setFill];
  }
  [roundedRect fill];

  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
}

- (void)drawForeground {
  UIBezierPath *path = [self pathOfSymbol];

  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextTranslateCTM(context, self.bounds.size.width/2, 0);

  CGFloat translationUnit = self.bounds.size.height/6;
  CGFloat translations[][3] =
      { {translationUnit*3},
        {translationUnit*2, translationUnit*2},
        {translationUnit, translationUnit*2, translationUnit*2}};
  for (int i = 0; i < self.number; ++i) {
    CGContextTranslateCTM(context, 0, translations[self.number-1][i]);
    [self drawColorAndShading:path];
  }
}

- (UIBezierPath *)pathOfSymbol {
  UIBezierPath *path = nil;
  if (self.symbol == 1) {
    path = [self pathOfDiamond];
  }
  else if (self.symbol == 2) {
    path = [self pathOfSquiggle];
  }
  else if (self.symbol == 3) {
    path = [self pathOfOval];
  }
  return path;
}

- (UIBezierPath *)pathOfDiamond {
  CGFloat halfWidth = self.bounds.size.width/3;
  CGFloat halfHeight = self.bounds.size.height/8;
  
  UIBezierPath *path = [[UIBezierPath alloc] init];
  [path moveToPoint:CGPointMake(-halfWidth, 0)];
  [path addLineToPoint:CGPointMake(0, -halfHeight)];
  [path addLineToPoint:CGPointMake(halfWidth, 0)];
  [path addLineToPoint:CGPointMake(0, halfHeight)];
  [path closePath];
  return path;
}

- (UIBezierPath *)pathOfOval {
  CGFloat halfWidth = self.bounds.size.width/3;
  CGFloat halfHeight = self.bounds.size.height/9;
  CGRect rect = CGRectMake(-halfWidth, -halfHeight, 2*halfWidth, 2*halfHeight);
  return [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:halfWidth];
}

- (UIBezierPath *)pathOfSquiggle {
  CGFloat halfWidth = self.bounds.size.width/4;
  CGFloat halfHeight = self.bounds.size.height/10;
  CGFloat shift = halfWidth/6;
  CGFloat controlSize = halfHeight;
  
  CGPoint p1 = CGPointMake(-halfWidth-shift, -halfHeight);
  CGPoint p2 = CGPointMake(halfWidth-shift, -halfHeight);
  CGPoint p3 = CGPointMake(halfWidth+shift, halfHeight);
  CGPoint p4 = CGPointMake(-halfWidth+shift, halfHeight);
  
  UIBezierPath *path = [[UIBezierPath alloc] init];
  [path moveToPoint:p1];
  [path addCurveToPoint:p2
          controlPoint1:CGPointMake(p1.x+controlSize, p1.y-controlSize)
          controlPoint2:CGPointMake(p2.x-controlSize, p2.y+controlSize)];
  
  [path addCurveToPoint:p3
          controlPoint1:CGPointMake(p2.x+controlSize, p2.y-controlSize)
          controlPoint2:CGPointMake(p3.x+controlSize, p3.y-controlSize)];
  
  [path addCurveToPoint:p4
          controlPoint1:CGPointMake(p3.x-controlSize, p3.y+controlSize)
          controlPoint2:CGPointMake(p4.x+controlSize, p4.y-controlSize)];
  
  [path addCurveToPoint:p1
          controlPoint1:CGPointMake(p4.x-controlSize, p4.y+controlSize)
          controlPoint2:CGPointMake(p1.x-controlSize, p1.y+controlSize)];
  
  return path;
}

- (void)drawColorAndShading:(UIBezierPath *)path {
  if (self.shading == 1) { // solid
    [[self symbolColor] setFill];
    [path fill];
  }
  else if (self.shading == 2) { // stripe
    [self drawStripeShading:path];
  }
  else if (self.shading == 3) { // open
    [[self symbolColor]  setStroke];
    [path stroke];
  }
}

- (void)drawStripeShading:(UIBezierPath *)path {
  // Copied from Stackoverflow
  
  CGRect bounds = path.bounds;
  // create a UIBezierPath for the fill pattern
  UIBezierPath *stripes = [UIBezierPath bezierPath];
  for ( int x = 0; x < bounds.size.width; x += 5 )
  {
    [stripes moveToPoint:CGPointMake( bounds.origin.x + x,bounds.origin.y )];
    [stripes addLineToPoint:CGPointMake(bounds.origin.x + x,
                                        bounds.origin.y + bounds.size.height)];
  }
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  // draw the fill pattern first, using the outline to clip
  CGContextSaveGState( context );
  [path addClip];
  [[self symbolColor] set];
  [stripes stroke];
  CGContextRestoreGState( context );
  // draw the outline of the shape
  [[self symbolColor] set];
  [path stroke];
}

- (void)setChosen:(BOOL)chosen {
  if (_chosen != chosen) {
    _chosen = chosen;
    [self setNeedsDisplay];
  }
}

- (UIColor *)symbolColor {
  return @[[UIColor redColor], [UIColor greenColor], [UIColor purpleColor]][self.color-1];
}

- (CGFloat)cornerScaleFactor {
  return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT;
}

- (CGFloat)cornerRaduis {
  return CORNER_RADIUS * [self cornerScaleFactor];
}

@end
