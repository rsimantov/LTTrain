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

static const float EPSILON = 0.01;

@interface ViewController () <UIDynamicAnimatorDelegate>
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic, readwrite) CardGame *game;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) NSMutableArray *attachmentBehaviors; // of UIAttachmentBehavior
@property (strong, nonatomic, readwrite) NSMutableDictionary *modelCardsToViewCards;
@property (strong, nonatomic, readwrite) NSMutableDictionary *cardIndexToFrame;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(deviceOrientationDidChangeNotification:)
                                               name:UIDeviceOrientationDidChangeNotification
                                             object:nil];
  [[self fetchCardsView] addGestureRecognizer:[[UIPinchGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector((pinchGestureHandler:))]];
}

- (void)tappedOnCardWithIndex:(NSUInteger)index {
  [self.game selectCardAtIndex:index];
  [self updateUI];
}

- (void)drawCards:(NSUInteger)number {
  NSMutableArray *cardViews = [[NSMutableArray alloc] init];
  for (NSUInteger i = 0; i < number; ++i) {
    NSInteger index = [self.game drawCard];
    if (index < 0) {
      //assert
      return;
    }
    [cardViews addObject:[self addCardViewForCard:[self.game cardAtIndex:index] withIndex:index]];
  }
  [self placeCards:cardViews];
}

- (IBAction)touchReDealButton:(UIButton *)sender {
  NSArray *cardViews = [self.modelCardsToViewCards allValues];
  [self clear];
  
  [UIView animateWithDuration:1.0
                        delay:0.0
                      options:UIViewAnimationOptionBeginFromCurrentState
                   animations:^{
                     [cardViews setValue:@0.0 forKey:@"alpha"];
                   }
                   completion:^(BOOL fin) {
                     if (fin) {
                       [cardViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                       [self dealNewGame];
                       [self updateUI];
                     }}];
}

- (void)clear {
  self.game = nil;
  [self.modelCardsToViewCards removeAllObjects];
  [self.cardIndexToFrame removeAllObjects];
}

- (void)dealNewGame {
  for (int i = 0; i < [self.game cardsCount]; ++i) {
    Card *card = [self.game cardAtIndex:i];
    [self addCardViewForCard:card withIndex:i];
  }
  [self placeCards:[self.modelCardsToViewCards allValues]]	;
}

#pragma mark Card placing

- (CardView *)addCardViewForCard:(Card *)card withIndex:(NSUInteger)index {
  CardView *cardView = [self createCardViewFromCard:card andFrame:[self deckFrame]];
  [self setGameGesturesForCard:cardView];
  [[self fetchCardsView] addSubview:cardView];
  [self.modelCardsToViewCards setObject:cardView forKey:[NSNumber numberWithUnsignedInteger:index]];
  [self.cardIndexToFrame setObject:[NSValue valueWithCGRect:[self findAvailableCellFrame]]
                            forKey:[NSNumber numberWithUnsignedInteger:index]];
  return cardView;
}

- (CGRect)deckFrame {
  CGRect frame = [[self createCardsGrid] frameOfCellAtRow:0 inColumn:0];
  frame.origin.x = [self fetchCardsView].frame.size.width/2;
  frame.origin.y = [[UIScreen mainScreen]bounds].size.height;
  return frame;
}

- (void)placeCards:(NSArray *)cardViews {
  for (NSUInteger i = 0; i < [cardViews count]; ++i) {
    [self placeCard:cardViews[i] withIndex:i];
  }
}

- (void)placeCard:(CardView *)cardView withIndex:(NSUInteger)index {
  NSArray * keys = [self.modelCardsToViewCards allKeysForObject:cardView];
  if ([keys count] != 1) {
    return;
  }
  NSValue *value = [self.cardIndexToFrame objectForKey:keys[0]];
  CGRect frame = [value CGRectValue];
  [UIView animateWithDuration:0.5
                        delay:0.1*index
                      options:UIViewAnimationOptionBeginFromCurrentState
                   animations:^{ cardView.frame = frame; }
                   completion:nil];
}

- (CGRect)findAvailableCellFrame {
  Grid *grid = [self createCardsGrid];
  for (int i = 0; i < grid.rowCount; ++i) {
    for (int j = 0; j < grid.columnCount; ++j) {
      CGRect cell = [grid frameOfCellAtRow:i inColumn:j];
      if ([self isCellAvailable:cell]) {
        return cell;
      }
    }
  }
  return CGRectMake(0,0,0,0);
}


- (BOOL)isCellAvailable:(CGRect)cell {
  for (NSValue *value in [self.cardIndexToFrame allValues]) {
    CGRect cardCell = [value CGRectValue];
    if ((fabs(cell.origin.x - cardCell.origin.x) < EPSILON) &&
        (fabs(cell.origin.y - cardCell.origin.y) < EPSILON))		 {
      return NO;
    }
  }
  return YES;
}

#pragma mark UI upadtes

- (void)updateUI {
  [self updateCardsUI];
  [self updateScoreLabel];
}

- (void)updateScoreLabel {
  [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %ld",self.game.score]];
}

- (void)updateCardsUI {
  for (NSUInteger i = 0; i < self.game.cardsCount; ++i) {
    Card *card = [self.game cardAtIndex:i];
    CardView *cardView =
        [self.modelCardsToViewCards objectForKey:[NSNumber numberWithUnsignedInteger:i]];
    if (! cardView) {
      continue;
    }
    [self updateCardView:cardView fromCard:card];
    if (card.matched) {
      [self removeCardView:cardView];
    }
  }
}

- (void)removeCardView:(CardView *)cardView {
  [UIView animateWithDuration:1.0
                        delay:1.0
                      options:UIViewAnimationOptionBeginFromCurrentState
                   animations:^{ cardView.frame = CGRectMake(cardView.frame.origin.x,
                                                             -[[UIScreen mainScreen]bounds].size.height,
                                                             cardView.frame.size.width,
                                                             cardView.frame.size.height); }
                   completion:^(BOOL fin) { if (fin) [cardView removeFromSuperview];}];
  NSNumber *cardIndex = [self.modelCardsToViewCards allKeysForObject:cardView][0];
  [self.modelCardsToViewCards removeObjectForKey:cardIndex];
  [self.cardIndexToFrame removeObjectForKey:cardIndex];
}

- (void)deviceOrientationDidChangeNotification:(NSNotification*)note {
  [self.cardIndexToFrame removeAllObjects]	;
  Grid *grid = [self createCardsGrid];
  NSUInteger gridIndex = 0;
  for (NSUInteger i = 0; i < [self.game cardsCount]; ++i) {
    if ([self.game cardAtIndex:i].matched) {
      continue;
    }
    CardView *cardView =
        [self.modelCardsToViewCards objectForKey:[NSNumber numberWithUnsignedInteger:i]];
    cardView.frame = [grid frameOfCellAtRow:gridIndex/grid.columnCount
                                             inColumn:gridIndex%grid.columnCount];
    [self.cardIndexToFrame setObject:[NSValue valueWithCGRect:cardView.frame]
                              forKey:[NSNumber numberWithUnsignedInteger:i]];
    ++gridIndex;
  }
}

#pragma mark Gestures

- (void)cardTapGesture:(UITapGestureRecognizer *)gesture {
  NSArray * keys = [self.modelCardsToViewCards allKeysForObject:(CardView *)gesture.view];
  if ([keys count] != 1) {
    return;
  }
  [self tappedOnCardWithIndex:[keys[0] unsignedIntegerValue]];
  
}

- (void)cardsPileTapGesture:(UITapGestureRecognizer *)gesture {
  for (CardView *cardView in [self.modelCardsToViewCards allValues]) {
    [self setGameGesturesForCard:cardView];
  }
  [self placeCards:[self.modelCardsToViewCards allValues]];
}


- (void)setGameGesturesForCard:(CardView *)cardView {
  for (UIGestureRecognizer *gr in cardView.gestureRecognizers) {
    [self.view removeGestureRecognizer:gr];
  }
  [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                  initWithTarget:self action:@selector((cardTapGesture:))]];
}

- (void)setAnimationGesturesForCard:(CardView *)cardView {
  for (UIGestureRecognizer *gr in cardView.gestureRecognizers) {
    [self.view removeGestureRecognizer:gr];
  }
  [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                  initWithTarget:self action:@selector((cardsPileTapGesture:))]];
  [cardView addGestureRecognizer:[[UIPanGestureRecognizer alloc]
                                  initWithTarget:self action:@selector((panGestureHandler:))]];
}

- (void)pinchGestureHandler:(UIPinchGestureRecognizer *)gesture {
  if (gesture.state != UIGestureRecognizerStateEnded) {
    return;
  }
  
  for (CardView *cardView in [self.modelCardsToViewCards allValues]) {
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                       UIView *cardsView = [self fetchCardsView];
                       cardView.frame = CGRectMake(cardsView.frame.size.width/2,
                                                   cardsView.frame.size.height/2,
                                                   cardView.frame.size.width,
                                                   cardView.frame.size.height); }
                     completion:nil];
    [self setAnimationGesturesForCard:cardView];
  }
}

- (void)panGestureHandler:(UIPanGestureRecognizer *)gesture {
  CGPoint gesturePoint = [gesture locationInView:[self fetchCardsView]];
  if (gesture.state == UIGestureRecognizerStateBegan) {
    [self attachCardsPileToPoint:gesturePoint];
  }
  else if (gesture.state == UIGestureRecognizerStateChanged) {
    [self updateCardsPileWithAnchorPoint:gesturePoint];
  }
  else if (gesture.state == UIGestureRecognizerStateEnded) {
    [self removeAttachmentBehaviorsForPileCards];
  }
}

- (void)attachCardsPileToPoint:(CGPoint)anchorPoint {
  for (CardView *cardView in [self.modelCardsToViewCards allValues]) {
    UIAttachmentBehavior * attachmentBehavior =
    [[UIAttachmentBehavior alloc] initWithItem:cardView
                              attachedToAnchor:anchorPoint];
    [self.attachmentBehaviors addObject:attachmentBehavior];
    [self.animator addBehavior:attachmentBehavior];
  }
}

- (void)updateCardsPileWithAnchorPoint:(CGPoint)anchorPoint {
  for (UIAttachmentBehavior *attachmentBehavior in self.attachmentBehaviors) {
    attachmentBehavior.anchorPoint = anchorPoint;
  }
}

- (void)removeAttachmentBehaviorsForPileCards {
  for (UIAttachmentBehavior *attachmentBehavior in self.attachmentBehaviors) {
    [self.animator removeBehavior:attachmentBehavior];
  }
}

#pragma mark Getters

- (CardGame *)game {
  if (!_game) {
    _game = [self createGame];
  }
  return _game;
}

- (UIDynamicAnimator *)animator {
  if (!_animator) {
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:[self fetchCardsView]];
    _animator.delegate = self;
  }
  return _animator;
}

- (NSMutableArray *)attachmentBehaviors {
  if (!_attachmentBehaviors) {
    _attachmentBehaviors = [[NSMutableArray alloc] init];
  }
  return _attachmentBehaviors;
}

- (NSMutableDictionary *)modelCardsToViewCards {
  if (!_modelCardsToViewCards) {
    _modelCardsToViewCards = [[NSMutableDictionary alloc] init];
  }
  return _modelCardsToViewCards;
}

- (NSMutableDictionary *)cardIndexToFrame {
  if (!_cardIndexToFrame) {
    _cardIndexToFrame = [[NSMutableDictionary alloc] init];
  }
  return _cardIndexToFrame;
}

#pragma mark Abstract methods

- (CardGame *)createGame { //abstract
  return nil;
}

- (Grid *)createCardsGrid { //abstract
  return nil;
}

- (UIView *)fetchCardsView { //abstract
  return nil;
}

- (CardView *)createCardViewFromCard:(Card *)card andFrame:(CGRect)frame { //abstract
  return nil;
}

- (void)updateCardView:(CardView *)cardView fromCard:(Card *)card {  // abstract
  return;
}

@end
