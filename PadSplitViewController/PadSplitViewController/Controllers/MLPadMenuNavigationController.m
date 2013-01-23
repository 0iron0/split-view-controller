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
    int _firstVisibleIndex;
    NSMutableArray *_controllersForRemoval;
}

- (void)configureSelf;

- (void)addController:(UIViewController <MenuViewController> *)controller;
- (void)removeController:(UIViewController *)controller;

- (void)slideControllerForwards:(UIViewController *)controller;
- (void)slideControllerBackwards:(UIViewController *)controller;

- (void)cleanUpControllers;

- (CGRect)frameForIndex:(int)index;

@end

@implementation MLPadMenuNavigationController

@synthesize minVisibleFrame = _minVisibleFrame;
@synthesize visibleControllers;
@synthesize maxVisibleControllers = _maxVisibleControllers;
@synthesize parent;

- (id)initWithRootViewController:(UIViewController <MenuViewController> *)rootController
{
    if (self = [super initWithNibName:nil bundle:nil])
    {
        [self configureSelf];
        [self addController:rootController];
    }
    return self;
}

- (void)dealloc
{
    [_viewControllers release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor clearColor];
}

- (void)viewDidLayoutSubviews
{
    for (UIViewController *controller in _viewControllers)
    {
        controller.view.frame = [self frameForIndex:[_viewControllers indexOfObject:controller]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View Configuration

- (void)configureSelf
{
    _firstVisibleIndex = 0;
    _viewControllers = [[NSMutableArray arrayWithCapacity:0] retain];
    _controllersForRemoval = [[NSMutableArray arrayWithCapacity:0] retain];
    _maxVisibleControllers = 1;
    self.view.clipsToBounds = NO;
}

#pragma mark - Pushing and Popping

- (void)pushViewController:(UIViewController <MenuViewController> *)viewController animated:(BOOL)animated
{    
    if (self.visibleControllers < self.maxVisibleControllers)
    {
        [self addController:viewController];
        [self slideControllerForwards:viewController];
        [self.parent slideContentControllerRight];
    }
    else
    {
        [self addController:viewController];
        [self slideBackwards];
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
    [self performSelector:@selector(doSomeSlids) withObject:nil afterDelay:0.2];
}

- (void)doSomeSlids
{
    if (![[NSThread currentThread] isMainThread])
    {
        [self performSelectorOnMainThread:@selector(doSomeSlids) withObject:nil waitUntilDone:YES];
        return;
    }
    if (self.visibleControllers > 1)
        [self.parent slideContentControllerLeft];
    [self slideBackwards];
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

#pragma mark - Navigation

- (void)slideForwards
{
    for (UIViewController *controller in _viewControllers)
    {
        [self slideControllerForwards:controller];
    }
    _firstVisibleIndex--;
}

- (void)slideBackwards
{
    if (![[NSThread currentThread] isMainThread]) {
        [self performSelectorOnMainThread:@selector(slideBackwards) withObject:nil waitUntilDone:YES];
        return;
    }
    if (_firstVisibleIndex == [_viewControllers count]-1)
    {
        [self performSelector:@selector(slideAndCleanUp) withObject:nil afterDelay:0.3];
        return;
    }
    
    for (UIViewController *controller in _viewControllers)
    {
        [self slideControllerBackwards:controller];
    }
    _firstVisibleIndex++;
}

- (void)slideControllerForwards:(UIViewController *)controller
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationCurveEaseOut
                     animations:^(void) {
                         controller.view.frame = CGRectMake(controller.view.frame.origin.x + controller.view.frame.size.width,
                                                            controller.view.frame.origin.y,
                                                            controller.view.frame.size.width,
                                                            controller.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         [self cleanUpControllers];
                     }];
}

- (void)slideControllerBackwards:(UIViewController *)controller
{
    MLPadMenuViewController *firstVisibleController = [_viewControllers objectAtIndex:_firstVisibleIndex+1];
    [firstVisibleController.navigationBar setBackButtonEnabled:YES animated:YES];

    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^(void) {
                         controller.view.frame = CGRectMake(controller.view.frame.origin.x - controller.view.frame.size.width,
                                                            controller.view.frame.origin.y,
                                                            controller.view.frame.size.width,
                                                            controller.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         [self cleanUpControllers];
                     }];
}

- (void)cleanUpControllers
{
    if (![[NSThread currentThread] isMainThread]) {
        [self performSelectorOnMainThread:@selector(cleanUpControllers) withObject:nil waitUntilDone:YES];
        return;
    }
    while ([_controllersForRemoval count] > 0)
    {
        UIViewController *controller = [_controllersForRemoval objectAtIndex:0];
        [controller.view removeFromSuperview];
        [_controllersForRemoval removeObjectAtIndex:0];
    }
}

- (void)slideAndCleanUp
{
    if (![[NSThread currentThread] isMainThread]) {
        [self performSelectorOnMainThread:@selector(slideAndCleanUp) withObject:nil waitUntilDone:YES];
        return;
    }
    if ([_controllersForRemoval count] > 0)
    {
        [self.parent slideContentControllerLeft];
        [self performSelector:@selector(cleanUpControllers) withObject:nil afterDelay:0.3];
    }
}

#pragma mark - Getters

- (UIViewController *)topViewController {
    if ([_viewControllers count] == 0)
        return nil;
    return [_viewControllers objectAtIndex:[_viewControllers count]-1];
}

- (UIViewController *)visibleViewController {
    return [_viewControllers objectAtIndex:_firstVisibleIndex];
}

- (NSMutableArray *)viewControllers {
    return _viewControllers;
}

#pragma mark - Setters

- (void)setMinVisibleFrame:(CGRect)minVisibleFrame {
    _minVisibleFrame = minVisibleFrame;
}

- (int)visibleControllers {
    return fminf([_viewControllers count] - _firstVisibleIndex, self.maxVisibleControllers);
}

#pragma mark - Utility

- (CGRect)frameForIndex:(int)index {
    return CGRectMake(self.minVisibleFrame.size.width * (index - _firstVisibleIndex),
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
    return (_firstVisibleIndex != [_viewControllers count]-1);
}

@end
