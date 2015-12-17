// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by rsimantov.

#import "ImageViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageViewController () <UIScrollViewDelegate, UISplitViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityBar;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic, nullable) UIImage *image;

@end

@implementation ImageViewController

#pragma mark -
#pragma mark ViewController
#pragma mark -

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.imageScrollView addSubview:self.imageView];
}

- (void)awakeFromNib {
  [super awakeFromNib];
  self.splitViewController.delegate = self;
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection
              withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  if (newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact &&
      newCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
    [self.navigationController popViewControllerAnimated:YES];
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self splitViewController:self.splitViewController
    willChangeToDisplayMode:self.splitViewController.displayMode];
}

#pragma mark -
#pragma mark UISplitViewControllerDelegate
#pragma mark -

- (void)splitViewController:(UISplitViewController *)svc
   willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode{
  if (displayMode == UISplitViewControllerDisplayModePrimaryHidden) {
    self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    self.navigationItem.leftItemsSupplementBackButton = YES;
  }
  else {
    self.navigationItem.leftBarButtonItem = nil;
  }
}

#pragma mark -
#pragma mark UIScrollViewDelegate
#pragma mark -

- (UIView * _Nullable)viewForZoomingInScrollView:(UIScrollView *)scrollView {
  return self.imageView;
}

#pragma mark -
#pragma mark Image download
#pragma mark -

- (void)startDownloadingImage {
  if (!self.imageURL) {
    return;
  }
  self.image = nil;
  [self.activityBar startAnimating];
  NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
  NSURLSessionConfiguration *configuration =
  [NSURLSessionConfiguration ephemeralSessionConfiguration];
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  NSURLSessionDownloadTask *task =
  [session downloadTaskWithRequest:request
                 completionHandler:^(NSURL * _Nullable location,
                                     NSURLResponse * _Nullable response,
                                     NSError * _Nullable error) {
                   if (error || (![request.URL isEqual:self.imageURL])) {
                     return;
                   }
                   UIImage *image =
                   [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                   dispatch_async(dispatch_get_main_queue(),
                                  ^{ self.image = image; });
                 }];
  [task resume];
}

#pragma mark -
#pragma mark Properties
#pragma mark -

- (void)setImageURL:(NSURL *)imageURL {
  if ([imageURL isEqual:_imageURL]) {
    return;
  }
  _imageURL = imageURL;
  [self startDownloadingImage];
}

- (void)setImageScrollView:(UIScrollView *)imageScrollView {
  _imageScrollView = imageScrollView;
  _imageScrollView.delegate = self;
  _imageScrollView.contentSize = self.image ? self.image.size : CGSizeZero;
}

- (UIImageView *)imageView {
  if (!_imageView) {
    _imageView = [[UIImageView alloc] init];
  }
  return _imageView;
}

- (UIImage * _Nullable)image {
  return self.imageView.image;
}

- (void)setImage:(UIImage * _Nullable)image {
  self.imageView.image = image;
  self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
  self.imageScrollView.contentSize = self.image ? self.image.size : CGSizeZero;
  self.imageScrollView.maximumZoomScale = 3.0;
  self.imageScrollView.minimumZoomScale =
      MIN(MIN(self.imageScrollView.frame.size.width/image.size.width,
              self.imageScrollView.frame.size.height/image.size.height),
          self.imageScrollView.maximumZoomScale);
  self.imageScrollView.zoomScale = self.imageScrollView.minimumZoomScale;

//  NSLog(@"%f %f %f %f",
//        image.size.width, self.imageScrollView.frame.size.width,
//        image.size.height,self.imageScrollView.frame.size.height);
//  NSLog(@"%f %f %f",
//        self.imageScrollView.maximumZoomScale, self.imageScrollView.minimumZoomScale,
//        self.imageScrollView.zoomScale);
  
  [self.activityBar stopAnimating];
}

@end

NS_ASSUME_NONNULL_END
