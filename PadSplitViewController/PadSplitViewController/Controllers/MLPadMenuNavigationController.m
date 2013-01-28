//
//  MLPadMenuNavigationController.m
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/2/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import "MLPadMenuNavigationController.h"
#import "MLPadMenuViewController.h"
#import "MLPadMenuNavigationBar.h"

@interface MLPadMenuNavigationController () {
    NSMutableArray *_viewControllers;
    NSMutableArray *_controllersForRemoval;
    UIScrollView *_scrollView;
}

- (void)configureSelf;
- (void)configureScrollView;

- (void)addController:(UIViewController <MenuViewController> *)controller;
- (void)removeController:(UIViewController *)controller;

- (void)animateControllersGivenFirstVisibleIndex:(int)index;
- (void)cleanUpControllers;

- (CGRect)frameForIndex:(int)index;
- (CGRect)frameForIndex:(int)index givenTargetFirstVisibleIndex:(int)firstVisible;

@end

@implementation MLPadMenuNavigationController

@synthesize minVisibleFrame = _minVisibleFrame;
@synthesize visibleControllers;
@synthesize maxVisibleControllers = _maxVisibleControllers;
@synthesize firstVisibleIndex;
@synthesize parent;


- (id)initWithRootViewController:(UIViewController <MenuViewController> *)rootController
{
    if (self = [super initWithNibName:nil bundle:nil])
    {
        [self configureSelf];
        [self configureScrollView];
        [self addController:rootController];
    }
    return self;
}


- (void)viewDidLayoutSubviews
{
    for (UIViewController *controller in _viewControllers)
    {
        controller.view.frame = [self frameForIndex:[_viewControllers indexOfObject:controller]];
    }
}

#pragma mark - View Configuration

- (void)configureSelf
{
    _viewControllers = [NSMutableArray arrayWithCapacity:0];
    _controllersForRemoval = [NSMutableArray arrayWithCapacity:0];
    _maxVisibleControllers = 1;
    self.view.clipsToBounds = NO;
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)configureScrollView
{
    _scrollView = [UIScrollView new];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _scrollView.frame = self.view.bounds;
    _scrollView.pagingEnabled = YES;
}

#pragma mark - Pushing and Popping

- (void)pushViewController:(UIViewController <MenuViewController> *)viewController animated:(BOOL)animated
{    
    if (self.visibleControllers < self.maxVisibleControllers)
    {
        [self addController:viewController];
        [self animateControllersGivenFirstVisibleIndex:self.firstVisibleIndex];
        [self.parent slideContentControllerRight];
    }
    else
    {
        [self addController:viewController];
        [self animateControllersGivenFirstVisibleIndex:self.firstVisibleIndex+1];
    }
}

- (void)popViewControllerAnimated:(BOOL)animated
{
    [self removeController:self.topViewController];
    [self slideForwards];
}

- (void)popToRootViewControllerAnimated:(BOOL)animated
{
    while (self.topViewController != [_viewControllers objectAtIndex:0]) {
        [self removeController:self.topViewController];
    }
}

- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    while (self.topViewController != viewController) {
        [self removeController:self.topViewController];
    }
}

- (void)presentContentControllerForItem:(MLCourseMapItem *)item animated:(BOOL)animated
{
    //if iphone, just pushViewController
    
    [self.parent presentContentControllerForItem:item animated:animated];
    [self animateControllersGivenFirstVisibleIndex:[_viewControllers count]-1];
}

- (void)addController:(UIViewController <MenuViewController> *)controller
{
    controller.view.frame = self.topViewController.view.frame;
    [self.view addSubview:controller.view];
    [self.view insertSubview:controller.view belowSubview:self.topViewController.view];
    [_viewControllers addObject:controller];
    controller.menuNavigationController = self;
    
    CGRect viewFrame = self.view.frame;
    viewFrame.size.width += self.minVisibleFrame.size.width;
    self.view.frame = viewFrame;
}

- (void)removeController:(UIViewController *)controller
{
    [_controllersForRemoval addObject:controller];
    [_viewControllers removeObject:controller];
}

#pragma mark - Sliding and Cleaning Up

- (void)slideForwards
{
    [self animateControllersGivenFirstVisibleIndex:self.firstVisibleIndex-1];
}

- (void)slideBackwards
{
    [self animateControllersGivenFirstVisibleIndex:self.firstVisibleIndex+1];
}

- (void)animateControllersGivenFirstVisibleIndex:(int)index
{
    if (index > 0) {
        MLPadMenuViewController *firstVisibleController = [_viewControllers objectAtIndex:index];
        [firstVisibleController.navigationBar setBackButtonEnabled:YES animated:YES];
    }
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         for (UIViewController *controller in _viewControllers)
                         {
                             controller.view.frame = [self frameForIndex:[_viewControllers indexOfObject:controller]
                                            givenTargetFirstVisibleIndex:index];
                         }
                     } completion:^(BOOL finished) {
                         [self cleanUpControllers];
                     }];
}

- (void)cleanUpControllers
{
    dispatch_async(dispatch_get_main_queue(), ^{
        while ([_controllersForRemoval count] > 0)
        {
            UIViewController *controller = [_controllersForRemoval objectAtIndex:0];
            [controller.view removeFromSuperview];
            [_controllersForRemoval removeObjectAtIndex:0];
        }
    });
}

#pragma mark - Getters

- (UIViewController *)topViewController {
    if ([_viewControllers count] == 0)
        return nil;
    return [_viewControllers objectAtIndex:[_viewControllers count]-1];
}

- (UIViewController *)visibleViewController {
    return [_viewControllers objectAtIndex:self.firstVisibleIndex];
}

- (NSMutableArray *)viewControllers {
    return _viewControllers;
}

- (int)visibleControllers {
    return fminf([_viewControllers count] - self.firstVisibleIndex, self.maxVisibleControllers);
}

- (int)firstVisibleIndex {
    for (UIViewController *controller in _viewControllers)
    {
        if (controller.view.frame.origin.x == 0) {
            return [_viewControllers indexOfObject:controller];
        }
    }
    return 0;
}

#pragma mark - Setters

- (void)setMinVisibleFrame:(CGRect)minVisibleFrame {
    _minVisibleFrame = minVisibleFrame;
}

#pragma mark - Utility

- (CGRect)frameForIndex:(int)index {
    return CGRectMake(self.minVisibleFrame.size.width * (index - self.firstVisibleIndex),
                      0,
                      self.minVisibleFrame.size.width,
                      self.minVisibleFrame.size.height);
}

- (CGRect)frameForIndex:(int)index givenTargetFirstVisibleIndex:(int)targetFirstVisible {
    return CGRectMake(self.minVisibleFrame.size.width * (index - targetFirstVisible),
                      0,
                      self.minVisibleFrame.size.width,
                      self.minVisibleFrame.size.height);
}

- (CGRect)totalFrame {
    return CGRectMake(0,
                      0,
                      self.minVisibleFrame.size.width * [_viewControllers count],
                      self.minVisibleFrame.size.height);
}

- (CGRect)currentlyVisibleFrame {
    return CGRectMake(self.minVisibleFrame.origin.x,
                      self.minVisibleFrame.origin.y,
                      self.minVisibleFrame.size.width * self.visibleControllers,
                      self.minVisibleFrame.size.height);
}

- (BOOL)hasHiddenController {
    return (self.firstVisibleIndex != [_viewControllers count]-1);
}

@end
