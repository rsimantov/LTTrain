//
//  StatsViewController.m
//  Matchismo
//
//  Created by Reuven Siman Tov on 11/17/15.
//  Copyright © 2015 Lightricks. All rights reserved.
//

#import "LogViewController.h"

@interface LogViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end


@implementation LogViewController

- (void)game:(NSAttributedString *)logText {
  _logText = logText;
  if (self.view.window) {
    [self updateUI];
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self updateUI];
}

- (void)updateUI {
  self.textView.attributedText = self.logText;
}

@end
