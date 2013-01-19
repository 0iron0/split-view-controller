//
//  MLPadRightViewController.m
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/14/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import "MLPadRightViewController.h"
#import "MLPadContentViewController.h"
#import "MLCourseMapItem.h"

@interface MLPadRightViewController () {
    UIView *_fadeView;
    UITapGestureRecognizer *_tapRecognizer;
    UIPanGestureRecognizer *_panRecognizer;
}

@property (nonatomic, retain) UIViewController *viewController;

- (void)configureFadeView;
- (void)configureTapRecognizer;
- (void)configurePanRecognizer;

- (void)fadeTapped:(UITapGestureRecognizer *)recognizer;
- (void)userPanned:(UIPanGestureRecognizer *)recognizer;

- (void)animateControllerFromRight:(UIViewController *)controller animated:(BOOL)animated;

@end

@implementation MLPadRightViewController

@synthesize viewController = _viewController;
@synthesize parent;

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        [self configureFadeView];
        [self configureTapRecognizer];
        [self configurePanRecognizer];
    }
    return self;
}

- (void)dealloc
{
    [_viewController release];
    [_fadeView release];
    [_tapRecognizer release];
    [_panRecognizer release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)configureFadeView
{
    _fadeView = [[UIView alloc] init];
    _fadeView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _fadeView.backgroundColor = [UIColor whiteColor];
    _fadeView.alpha = 0;
}

- (void)configureTapRecognizer
{
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fadeTapped:)];
    [_fadeView addGestureRecognizer:_tapRecognizer];
    [_tapRecognizer release];
}

- (void)configurePanRecognizer
{
    _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(userPanned:)];
}

#pragma mark - Fading

- (void)addFade
{
    _fadeView.frame = _viewController.view.bounds;
    [_viewController.view addSubview:_fadeView];
    _fadeView.alpha = 0.7;
}

- (void)fadeFade
{
    _fadeView.alpha = 0;
}

- (void)removeFade
{
    [_fadeView removeFromSuperview];
}

#pragma mark - Gesture Handling

- (void)fadeTapped:(UITapGestureRecognizer *)recognizer
{
    [self.parent slideContentControllerLeft];
}

- (void)userPanned:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        if ([recognizer translationInView:recognizer.view].x >= 50)
        {
            if (![self isFaded])
                [self.parent slideContentControllerRight];
        }
        else if ([recognizer translationInView:recognizer.view].x <= -50)
        {
            if ([self isFaded])
                [self.parent slideContentControllerLeft];
        }
    }
}

#pragma mark - Content Presentation

- (void)presentContentControllerForItem:(MLCourseMapItem *)item animated:(BOOL)animated
{
    UIViewController *controller = [[[MLPadContentViewController alloc] init] autorelease];
    controller.view.frame = self.view.bounds;
    [self.view addSubview:controller.view];
    [self animateControllerFromRight:controller animated:YES];
    [controller.view addGestureRecognizer:_panRecognizer];
}

- (void)presentWebControllerForURL:(NSURL *)url
{
    
}

#pragma mark - Animation

- (void)animateControllerFromRight:(UIViewController *)controller animated:(BOOL)animated
{
    CGRect destinationFrame = controller.view.frame;
    controller.view.frame = CGRectMake(controller.view.frame.origin.x + controller.view.frame.size.width,
                                       controller.view.frame.origin.y,
                                       controller.view.frame.size.width,
                                       controller.view.frame.size.height);
    
    [UIView animateWithDuration:(animated ? 0.3 : 0)
                          delay:0.3
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         controller.view.frame = destinationFrame;
                         
                     } completion:^(BOOL finished) {
//                         [self removeFade];
                         [self.view.superview bringSubviewToFront:self.view];
                         [_viewController.view removeFromSuperview];
                         self.viewController = controller;
                     }];
}

#pragma mark - Utility

- (BOOL)isDisplayingController {
    return (_viewController != nil);
}

- (BOOL)isFaded {
    return (_fadeView.alpha > 0);
}

@end
