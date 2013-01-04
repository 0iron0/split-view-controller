//
//  MLPadSplitViewController.m
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/2/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import "MLPadSplitViewController.h"
#import "MLPadMenuNavigationController.h"
#import "MLPadMenuViewController.h"

@interface MLPadSplitViewController ()

- (void)configureLeftViewController;
- (void)configureRightViewController;

- (CGRect)leftControllerQuarterViewRect;
- (CGRect)leftControllerTwoQuarterViewRect;
- (CGRect)leftControllerThreeQuarterViewRect;
- (CGRect)rightControllerFrame;

@end

@implementation MLPadSplitViewController

@synthesize leftViewController = _leftViewController;
@synthesize rightViewController = _rightViewController;

#pragma mark - Controller Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureLeftViewController];
    [self configureRightViewController];
}

- (void)viewDidLayoutSubviews
{
    _leftViewController.visibleFrame = [self leftControllerQuarterViewRect];
    _leftViewController.view.frame = [self leftControllerQuarterViewRect];
    _rightViewController.view.frame = [self rightControllerFrame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [_leftViewController release];
    [_rightViewController release];
}

#pragma mark - View Configuration

- (void)configureLeftViewController
{
    MLPadMenuViewController *rootController = [[MLPadMenuViewController alloc] initWithNibName:nil bundle:nil];
    
    _leftViewController = [[MLPadMenuNavigationController alloc] initWithRootViewController:rootController];
    _leftViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_leftViewController.view];
    
    [rootController release];
}

- (void)configureRightViewController
{
    _rightViewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    _rightViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _rightViewController.view.backgroundColor = [UIColor colorWithRed:228.0/255 green:228.0/255 blue:228.0/255 alpha:1.0];
    [self.view addSubview:_rightViewController.view];
    [self addChildViewController:_rightViewController];
}

#pragma mark - Controller Presentation Methods

- (void)presentPopupViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

- (void)presentPinViewController:(UIViewController *)pinController animated:(BOOL)animated
{
    
}

#pragma mark - Frame Defines

- (CGRect)leftControllerQuarterViewRect {
    return CGRectMake(self.view.bounds.origin.x,
                      self.view.bounds.origin.y,
                      floorf(self.view.bounds.size.width / 4),
                      self.view.bounds.size.height);
}

- (CGRect)leftControllerTwoQuarterViewRect {
    return CGRectMake(self.view.bounds.origin.x,
                      self.view.bounds.origin.y,
                      floorf(self.view.bounds.size.width / 2),
                      self.view.bounds.size.height);
}

- (CGRect)leftControllerThreeQuarterViewRect {
    return CGRectMake(self.view.bounds.origin.x,
                      self.view.bounds.origin.y,
                      floorf(self.view.bounds.size.width / 4) * 3,
                      self.view.bounds.size.height);
}

- (CGRect)rightControllerFrame {
    return CGRectMake(CGRectGetMaxX(_leftViewController.visibleFrame),
                      _leftViewController.visibleFrame.origin.y,
                      floorf(self.view.bounds.size.width / 4) * 3,
                      _leftViewController.visibleFrame.size.height);
}

@end
