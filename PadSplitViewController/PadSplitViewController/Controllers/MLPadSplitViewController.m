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
    int _currentRightIndex;
}

- (void)configureLeftViewController;
- (void)configureRightViewController;
- (void)configureBackgroundView;
- (void)configureNavBar;
- (void)configureBottomDivider;

- (CGRect)leftControllerQuarterViewRect;
- (CGRect)rightControllerRelativeFrame;
- (CGRect)rightControllerBaseFrame;

- (CGSize)padViewSize;
- (BOOL)leftControllerShouldBeVisible;
- (int)maxVisibleLeftControllers;
- (int)minVisibleLeftControllers;
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
    _currentRightIndex = -1;
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
    _rightViewController.view.frame = [self rightControllerRelativeFrame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    
}

- (void)configureRightViewController
{
    _rightViewController = [[MLPadRightViewController alloc] initWithNibName:nil bundle:nil];
    _rightViewController.parent = self;
    _rightViewController.view.frame = [self rightControllerBaseFrame];
    [self.view addSubview:_rightViewController.view];
    [self.view sendSubviewToBack:_rightViewController.view];
}

- (void)configureBackgroundView
{
    _backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _backgroundView.backgroundColor = [UIColor colorWithRed:227.0/255 green:227.0/255 blue:227.0/255 alpha:1.0];
    [self.view addSubview:_backgroundView];
}

- (void)configureNavBar
{
    _backgroundNavBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    _backgroundNavBar.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1.0];
    _backgroundNavBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_backgroundNavBar];
}

- (void)configureBottomDivider
{
    UIView *bottomDivider = [[UIView alloc] initWithFrame:CGRectMake(0, 43, _backgroundNavBar.bounds.size.width, 1)];
    bottomDivider.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    bottomDivider.backgroundColor = [UIColor colorWithRed:189.0/255 green:189.0/255 blue:189.0/255 alpha:1.0];
    [_backgroundNavBar addSubview:bottomDivider];
}

#pragma mark - Controller Presentation Methods

- (void)presentContentControllerForItem:(MLCourseMapItem *)item animated:(BOOL)animated
{
//    if (![_rightViewController isDisplayingController])
//        _leftViewController.maxVisibleControllers = [self maxVisibleLeftControllers];
    
    [self.view bringSubviewToFront:_rightViewController.view];
    [_rightViewController presentContentControllerForItem:item animated:animated];
    [self slideContentControllerToBase];
    originalVisibleIndex = -1;
}

- (void)presentPopupViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

- (void)presentPinViewController:(UIViewController *)pinController animated:(BOOL)animated
{
    
}

#pragma mark - Sliding

- (void)slideContentControllerToBase
{
    _currentRightIndex = [self minRightIndex];

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

- (void)slideContentControllerRight
{
    CGRect destinationFrame = _rightViewController.view.frame;
    destinationFrame.origin.x += (_rightViewController.view.bounds.size.width/3);
    _currentRightIndex++;

    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _rightViewController.view.frame = destinationFrame;
                         [_rightViewController addFade];
                     } completion:^(BOOL finished) {
                     }];
}

- (void)slideContentControllerToMax
{
//    if (CGRectEqualToRect(_rightViewController.view.frame, [self rightControllerRelativeFrame]))
//        return;
    _currentRightIndex = [self maxRightIndex];

    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [_rightViewController addFade];
                         _rightViewController.view.frame = [self rightControllerRelativeFrame];
                     } completion:^(BOOL finished) {
                     }];
}

static int originalVisibleIndex = -1;

- (void)slideContentControllerToClosestSide
{    
    CGRect closestFrame = [self closestRectToTarget:_rightViewController.view.frame
                                          givenRect:[self rightControllerBaseFrame]
                                            andRect:[self rightControllerMaxFrame]];
    
    CGRect targetFrame = _leftViewController.view.frame;
    int firstVisibleIndex = _leftViewController.firstVisibleIndex;
    if (CGRectEqualToRect(closestFrame, [self rightControllerMaxFrame])) {
        targetFrame.origin.x = ((fminf([self maxRightIndex], [_leftViewController.viewControllers count])-1) * _leftViewController.minVisibleFrame.size.width);
        
        [self slideContentControllerToMax];
        if (([_leftViewController.viewControllers count] - firstVisibleIndex) < [self maxVisibleLeftControllers])
            firstVisibleIndex = [_leftViewController.viewControllers count] - [self maxVisibleLeftControllers];
    }
    else {        
        targetFrame.origin.x = 0;

        [self slideContentControllerToBase];
        firstVisibleIndex = originalVisibleIndex;
        originalVisibleIndex = -1;
    }
    [_leftViewController animateControllersGivenFirstVisibleIndex:firstVisibleIndex];

    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _leftViewController.view.frame = _leftViewController.totalFrame;
                     } completion:^(BOOL finished) {
                     }];
}

- (void)movedRightControllerDistance:(float)distance
{
    if ([self leftControllerHasExpanded] && distance > 0 && _leftViewController.view.frame.origin.x == 0)
        return;
    
    if (originalVisibleIndex < 0)
        originalVisibleIndex = _leftViewController.firstVisibleIndex;
    
    CGRect leftFrame = _leftViewController.view.frame;
    leftFrame.origin.x = _rightViewController.view.frame.origin.x - leftFrame.size.width;
    
//    if (originalVisibleIndex != _leftViewController.firstVisibleIndex) {
//        leftFrame.size.width = _leftViewController.visibleControllers * _leftViewController.minVisibleFrame.size.width;
//        originalVisibleIndex = _leftViewController.firstVisibleIndex;
//    }
    
    float maxOrigin = (fminf([self maxRightIndex]-1, originalVisibleIndex/*[_leftViewController.viewControllers count]*/) * _leftViewController.minVisibleFrame.size.width);
    float minOrigin = ([self leftControllerHasExpanded]) ? (-originalVisibleIndex * _leftViewController.minVisibleFrame.size.width) : 0;
    
    if (_rightViewController.view.frame.origin.x > maxOrigin + leftFrame.size.width && leftFrame.origin.x < maxOrigin)
        return;
    
    if (leftFrame.origin.x > maxOrigin)
        leftFrame.origin.x = maxOrigin;
    else if (leftFrame.origin.x < minOrigin)
        leftFrame.origin.x = minOrigin;
    
    _leftViewController.view.frame = leftFrame;
}

- (CGRect)closestRectToTarget:(CGRect)targetRect givenRect:(CGRect)rectOne andRect:(CGRect)rectTwo
{
    float differenceOne = fabsf(targetRect.origin.x - rectOne.origin.x);
    float differenceTwo = fabsf(targetRect.origin.x - rectTwo.origin.x);
    
    if (differenceOne < differenceTwo)
        return rectOne;
    return rectTwo;
}

- (BOOL)leftControllerHasExpanded {
    return (_leftViewController.view.bounds.size.width > _leftViewController.minVisibleFrame.size.width);
}

#pragma mark - Frame Defines

- (CGRect)leftControllerQuarterViewRect {
    return CGRectMake(self.view.bounds.origin.x,
                      self.view.bounds.origin.y,
                      floorf([self padViewSize].width / 4),
                      self.view.bounds.size.height);
}

- (CGRect)rightControllerRelativeFrame {
    int visibleControllers = _leftViewController.visibleControllers;
    if ([self minVisibleLeftControllers] == 0 && ![_rightViewController isFaded])
        visibleControllers = 0;
    
    return CGRectMake(_leftViewController.minVisibleFrame.size.width * [self currentRightIndex],
                      _leftViewController.minVisibleFrame.origin.y,
                      floorf([self padViewSize].width / 4) * 3,
                      _leftViewController.minVisibleFrame.size.height);
}

- (CGRect)rightControllerBaseFrame {
    return CGRectMake(_leftViewController.minVisibleFrame.size.width * [self minVisibleLeftControllers],
                      _leftViewController.minVisibleFrame.origin.y,
                      floorf([self padViewSize].width / 4) * 3,
                      _leftViewController.minVisibleFrame.size.height);
}

- (CGRect)rightControllerMaxFrame {
    return CGRectMake(_leftViewController.minVisibleFrame.size.width * [self maxRightIndex],
                      _leftViewController.minVisibleFrame.origin.y,
                      floorf([self padViewSize].width / 4) * 3,
                      _leftViewController.minVisibleFrame.size.height);
}

- (int)currentRightIndex
{
    if (_currentRightIndex == -1)
        _currentRightIndex = ([self isLandscape]) ? 1 : 0;
    
    return _currentRightIndex;
}

- (int)maxRightIndex {
    return fminf([self maxVisibleLeftControllers], [_leftViewController.viewControllers count]);
}

- (int)minRightIndex {
    return [self minVisibleLeftControllers];
}

#pragma mark - Utility

- (CGSize)padViewSize {
    return CGSizeMake(1024 /*fmaxf(self.view.bounds.size.width, self.view.bounds.size.height)*/,
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
    if ([self isLandscape] || ![_rightViewController isDisplayingController])
        return 3;
    return 2;
}

- (int)minVisibleLeftControllers {
    if ([self isLandscape])
        return 1;
    return 0;
}

- (BOOL)isLandscape {
    return UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation);
}

- (BOOL)rightControllerIsPastLastLeftController {
    return (_rightViewController.view.frame.origin.x > CGRectGetMaxX(_leftViewController.view.frame));
}

- (BOOL)rightControllerIsBeforeBase {
    return (_rightViewController.view.frame.origin.x < [self rightControllerBaseFrame].origin.x);
}

#pragma mark - Temporary Methods

- (void)setCoursesForController:(MLPadMenuCourseViewController *)controller
{
    MLCourse *course1 = [[MLCourse alloc] init];
    course1.title = @"English 402";
    course1.color = [UIColor colorWithRed:213.0/255 green:20.0/255 blue:37.0/255 alpha:1.0];
    course1.unreadItems = 8;
    
    MLCourse *course2 = [[MLCourse alloc] init];
    course2.title = @"Effective Literacy";
    course2.color = [UIColor colorWithRed:63.0/255 green:117.0/255 blue:205.0/255 alpha:1.0];
    course2.unreadItems = 4;
    
    MLCourse *course3 = [[MLCourse alloc] init];
    course3.title = @"Theories-Meth";
    course3.color = [UIColor colorWithRed:42.0/255 green:203.0/255 blue:133.0/255 alpha:1.0];
    course3.unreadItems = 0;
    
    MLCourse *course4 = [[MLCourse alloc] init];
    course4.title = @"Greek Philosophy";
    course4.color = [UIColor colorWithRed:189.0/255 green:65.0/255 blue:200.0/255 alpha:1.0];
    course4.unreadItems = 6;
    
    controller.courses = [NSArray arrayWithObjects:course1, course2, course3, course4, nil];
}

@end