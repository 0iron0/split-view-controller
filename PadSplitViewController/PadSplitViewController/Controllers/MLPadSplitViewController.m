//
//  MLPadSplitViewController.m
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/2/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import "MLPadSplitViewController.h"
#import "MLPadMenuNavigationController.h"
#import "MLPadMenuCourseViewController.h"
#import "MLPadRightViewController.h"
#import "MLCourse.h"
#import "MLCourseMapItem.h"

@interface MLPadSplitViewController () {
    UIView *_backgroundNavBar;
    UIView *_backgroundView;
}

- (void)configureLeftViewController;
- (void)configureRightViewController;
- (void)configureBackgroundView;
- (void)configureNavBar;
- (void)configureBottomDivider;

- (CGRect)leftControllerQuarterViewRect;
- (CGRect)rightControllerBaseFrame;

- (CGSize)padViewSize;
- (BOOL)leftControllerShouldBeVisible;
- (int)maxVisibleLeftControllers;
- (BOOL)isLandscape;

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
    
    [self configureBackgroundView];
    [self configureNavBar];
    [self configureBottomDivider];
    [self configureLeftViewController];
    [self configureRightViewController];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.view setNeedsLayout];
}

- (void)viewDidLayoutSubviews
{
    _leftViewController.minVisibleFrame = [self leftControllerQuarterViewRect];
    _leftViewController.maxVisibleControllers = [self maxVisibleLeftControllers];
    _leftViewController.view.frame = _leftViewController.totalFrame;
    _rightViewController.view.frame = [self rightControllerBaseFrame];
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
    MLPadMenuCourseViewController *rootController = [[MLPadMenuCourseViewController alloc] initWithNibName:nil bundle:nil];
    [self setCoursesForController:rootController];
        
    _leftViewController = [[MLPadMenuNavigationController alloc] initWithRootViewController:rootController];
    _leftViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _leftViewController.view.autoresizesSubviews = NO;
    _leftViewController.parent = self;
    [self.view addSubview:_leftViewController.view];
    
    [rootController release];
}

- (void)configureRightViewController
{
    _rightViewController = [[MLPadRightViewController alloc] initWithNibName:nil bundle:nil];
    _rightViewController.parent = self;
    [self.view addSubview:_rightViewController.view];
}

- (void)configureBackgroundView
{
    _backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _backgroundView.backgroundColor = [UIColor colorWithRed:227.0/255 green:227.0/255 blue:227.0/255 alpha:1.0];
    [self.view addSubview:_backgroundView];
    [_backgroundView release];
}

- (void)configureNavBar
{
    _backgroundNavBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    _backgroundNavBar.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1.0];
    _backgroundNavBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_backgroundNavBar];
    [_backgroundNavBar release];
}

- (void)configureBottomDivider
{
    UIView *bottomDivider = [[UIView alloc] initWithFrame:CGRectMake(0, 43, _backgroundNavBar.bounds.size.width, 1)];
    bottomDivider.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    bottomDivider.backgroundColor = [UIColor colorWithRed:189.0/255 green:189.0/255 blue:189.0/255 alpha:1.0];
    [_backgroundNavBar addSubview:bottomDivider];
    [bottomDivider release];
}

#pragma mark - Controller Presentation Methods

- (void)presentContentControllerForItem:(MLCourseMapItem *)item animated:(BOOL)animated
{
    [_rightViewController presentContentControllerForItem:item animated:animated];
    
    if (![_rightViewController isDisplayingController])
        [self slideContentControllerLeft];
}

- (void)presentPopupViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

- (void)presentPinViewController:(UIViewController *)pinController animated:(BOOL)animated
{
    
}

#pragma mark - Sliding

- (void)slideContentControllerRight
{
//    if (![_leftViewController hasHiddenController] && UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
//          return;
    
    CGRect destinationFrame = _rightViewController.view.frame;
    destinationFrame.origin.x += (_rightViewController.view.bounds.size.width/3);
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _rightViewController.view.frame = destinationFrame;
                         [_rightViewController addFade];
                     } completion:nil];
}

- (void)slideContentControllerLeft
{
    if (![_rightViewController isFaded] && [_rightViewController isDisplayingController])
        return;
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _rightViewController.view.frame = [self rightControllerBaseFrame];
                         [_rightViewController fadeFade];
                     } completion:^(BOOL finished) {
                         [_rightViewController removeFade];
                     }];
}

#pragma mark - Frame Defines

- (CGRect)leftControllerQuarterViewRect {
    return CGRectMake(self.view.bounds.origin.x,
                      self.view.bounds.origin.y,
                      floorf([self padViewSize].width / 4),
                      self.view.bounds.size.height);
}

- (CGRect)rightControllerBaseFrame {
    float xOrigin = 0;
    if ([self isLandscape])
        xOrigin = _leftViewController.minVisibleFrame.size.width;
    
    return CGRectMake(xOrigin,
                      _leftViewController.minVisibleFrame.origin.y,
                      floorf([self padViewSize].width / 4) * 3,
                      _leftViewController.minVisibleFrame.size.height);
}

#pragma mark - Utility

- (CGSize)padViewSize {
    return CGSizeMake(fmaxf(self.view.bounds.size.width, self.view.bounds.size.height),
                      fminf(self.view.bounds.size.width, self.view.bounds.size.height));
}

- (BOOL)leftControllerShouldBeVisible {
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
        return YES;
    else if (![_rightViewController isDisplayingController] || [_rightViewController isFaded])
        return YES;
    return NO;
}

- (int)maxVisibleLeftControllers {
    if ([self isLandscape])
        return 3;
    return 2;
}

- (BOOL)isLandscape {
    return UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation);
}

#pragma mark - Temporary Methods

- (void)setCoursesForController:(MLPadMenuCourseViewController *)controller
{
    MLCourse *course1 = [[[MLCourse alloc] init] autorelease];
    course1.title = @"English 402";
    course1.color = [UIColor colorWithRed:213.0/255 green:20.0/255 blue:37.0/255 alpha:1.0];
    course1.unreadItems = 8;
    
    MLCourse *course2 = [[[MLCourse alloc] init] autorelease];
    course2.title = @"Effective Literacy";
    course2.color = [UIColor colorWithRed:63.0/255 green:117.0/255 blue:205.0/255 alpha:1.0];
    course2.unreadItems = 4;
    
    MLCourse *course3 = [[[MLCourse alloc] init] autorelease];
    course3.title = @"Theories-Meth";
    course3.color = [UIColor colorWithRed:42.0/255 green:203.0/255 blue:133.0/255 alpha:1.0];
    course3.unreadItems = 0;
    
    MLCourse *course4 = [[[MLCourse alloc] init] autorelease];
    course4.title = @"Greek Philosophy";
    course4.color = [UIColor colorWithRed:189.0/255 green:65.0/255 blue:200.0/255 alpha:1.0];
    course4.unreadItems = 6;
    
    controller.courses = [NSArray arrayWithObjects:course1, course2, course3, course4, nil];
}

@end
