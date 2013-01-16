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
    UIView *_backgroundNavBar;
    UIView *_backgroundView;
}

@property (nonatomic, retain) UIViewController *viewController;

- (void)configureBackgroundView;
- (void)configureNavBar;
- (void)configureBottomDivider;

- (void)animateControllerFromRight:(UIViewController *)controller animated:(BOOL)animated;

@end

@implementation MLPadRightViewController

@synthesize viewController = _viewController;

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
//        [self configureBackgroundView];
        [self configureNavBar];
        [self configureBottomDivider];
    }
    return self;
}

- (void)dealloc
{
    [_viewController release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark - Configuration

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

#pragma mark - Content Presentation

- (void)presentContentControllerForItem:(MLCourseMapItem *)item animated:(BOOL)animated
{
    UIViewController *controller = [[[MLPadContentViewController alloc] init] autorelease];
    controller.view.frame = self.view.bounds;
    [self.view addSubview:controller.view];
    [self animateControllerFromRight:controller animated:YES];
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
                         [self.view.superview bringSubviewToFront:self.view];
                         [_viewController.view removeFromSuperview];
                         self.viewController = controller;
                     }];
}

- (void)slideRight
{
    CGRect destinationFrame = _viewController.view.frame;
    destinationFrame.origin.x += (destinationFrame.size.width/3);
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _viewController.view.frame = destinationFrame;
                     } completion:^(BOOL finished) {
                         
                     }];
}

#pragma mark - Utility

- (BOOL)isDisplayingController {
    return (_viewController != nil);
}

@end
