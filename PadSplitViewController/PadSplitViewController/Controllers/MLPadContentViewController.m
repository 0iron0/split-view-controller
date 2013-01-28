//
//  MLPadContentViewController.m
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/16/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import "MLPadContentViewController.h"
#import "MLPadMenuNavigationBar.h"
#import "MLPadRightViewController.h"

#define CONTENT_NAV_BAR_HEIGHT 44

@interface MLPadContentViewController () {
    
}

- (void)configureSelf;
- (void)configureImageView;
- (void)configureNavigationBar;

- (CGRect)navigationBarFrame;

@end

@implementation MLPadContentViewController

@synthesize parent = _parent;
@synthesize navigationBar = _navigationBar;

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        [self configureSelf];
        [self configureImageView];
        [self configureNavigationBar];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews
{
    if ([self shouldShowNavigationBar]) {
        if (!_navigationBar.superview)
            [self.view addSubview:_navigationBar];
    }
    else
        [_navigationBar removeFromSuperview];
}

#pragma mark - Configuration

- (void)configureSelf
{
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}

- (void)configureImageView
{
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"6.2-Comment.png"]];
    image.frame = self.view.bounds;
    image.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:image];
}

- (void)configureNavigationBar
{
    _navigationBar = [[MLPadMenuNavigationBar alloc] init];
    _navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _navigationBar.frame = [self navigationBarFrame];
    [_navigationBar setMenuButtonEnabled:YES animated:NO];
}

#pragma mark - Frames

- (CGRect)navigationBarFrame {
    return CGRectMake(0,
                      0,
                      self.view.bounds.size.width,
                      CONTENT_NAV_BAR_HEIGHT);
}

#pragma mark - Utility

- (BOOL)shouldShowNavigationBar {
    return UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation);
}

#pragma mark - Setters

- (void)setParent:(MLPadRightViewController *)parent {
    _parent = parent;
    _navigationBar.parent = parent;
}

@end
