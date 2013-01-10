//
//  MLPadMenuNavigationController.m
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/2/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import "MLPadMenuNavigationController.h"
#import "MLPadMenuViewController.h"

@interface MLPadMenuNavigationController () {
    NSMutableArray *_viewControllers;
    int _firstVisibleIndex;
}

- (void)configureSelf;

- (void)addController:(UIViewController <MenuViewController> *)controller;
- (void)removeController:(UIViewController *)controller;

- (void)slideControllerForwards:(UIViewController *)controller;
- (void)slideControllerBackwards:(UIViewController *)controller;

- (CGRect)frameForIndex:(int)index;

@end

@implementation MLPadMenuNavigationController

@synthesize minVisibleFrame = _minVisibleFrame;
@synthesize visibleControllers = _visibleControllers;
@synthesize maxVisibleControllers = _maxVisibleControllers;

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
    _visibleControllers = 1;
    _maxVisibleControllers = 1;
    self.view.clipsToBounds = NO;
}

#pragma mark - Pushing and Popping

- (void)pushViewController:(UIViewController <MenuViewController> *)viewController animated:(BOOL)animated
{
    viewController.view.frame = self.topViewController.view.frame;
    [self addController:viewController];
    [self.view sendSubviewToBack:viewController.view];
    
    if (self.visibleControllers < self.maxVisibleControllers)
    {
        [self slideControllerForwards:viewController];
        self.visibleControllers++;
    }
    else
    {
        for (int i = 0; i < [_viewControllers count]-1; i++)
        {
            [self slideControllerBackwards:[_viewControllers objectAtIndex:i]];
        }
        _firstVisibleIndex++;
    }
}

- (void)popViewControllerAnimated:(BOOL)animated
{
    [self removeController:[_viewControllers objectAtIndex:[_viewControllers count]-1]];
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

- (void)presentContentViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //if iphone, just pushViewController
    
    //if ipad tell parent to present
}

- (void)addController:(UIViewController <MenuViewController> *)controller
{
    [self.view addSubview:controller.view];
    [_viewControllers addObject:controller];
    controller.menuNavigationController = self;
    
    CGRect viewFrame = self.view.frame;
    viewFrame.size.width += self.minVisibleFrame.size.width;
    self.view.frame = viewFrame;
}

- (void)removeController:(UIViewController *)controller
{
    [controller.view removeFromSuperview];
    [_viewControllers removeObject:controller];
    
    if (self.visibleControllers > [_viewControllers count])
        self.visibleControllers = [_viewControllers count];
    else
        self.visibleControllers = fminf([_viewControllers count] - _firstVisibleIndex, self.maxVisibleControllers);
    
    CGRect viewFrame = self.view.frame;
    viewFrame.size.width -= self.minVisibleFrame.size.width;
    self.view.frame = viewFrame;
}

#pragma mark - Navigation

- (void)slideForwards
{
    for (UIViewController *controller in _viewControllers)
    {
        [self slideControllerForwards:controller];
    }
}

- (void)slideBackwards
{
    for (UIViewController *controller in _viewControllers)
    {
        [self slideControllerBackwards:controller];
    }
}

- (void)slideControllerForwards:(UIViewController *)controller
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^(void) {
                         controller.view.frame = CGRectMake(controller.view.frame.origin.x + controller.view.frame.size.width,
                                                            controller.view.frame.origin.y,
                                                            controller.view.frame.size.width,
                                                            controller.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {

                     }];
}

- (void)slideControllerBackwards:(UIViewController *)controller
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationCurveEaseOut
                     animations:^(void) {
                         controller.view.frame = CGRectMake(controller.view.frame.origin.x - controller.view.frame.size.width,
                                                            controller.view.frame.origin.y,
                                                            controller.view.frame.size.width,
                                                            controller.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

#pragma mark - Getters

- (UIViewController *)topViewController {
    return [_viewControllers objectAtIndex:[_viewControllers count]-1];
}

- (UIViewController *)visibleViewController {
    return [_viewControllers objectAtIndex:_firstVisibleIndex]; //IMPLEMENT THIS
}

- (NSMutableArray *)viewControllers {
    return _viewControllers;
}

#pragma mark - Setters

- (void)setMinVisibleFrame:(CGRect)minVisibleFrame {
    _minVisibleFrame = minVisibleFrame;
}
- (void)setVisibleControllers:(int)visibleControllers {
    _visibleControllers = visibleControllers;

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

@end
