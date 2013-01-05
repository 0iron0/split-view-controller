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
    int _currentIndex;
}

- (void)configureSelf;
- (void)addController:(UIViewController <MenuViewController> *)controller;

- (CGRect)frameForIndex:(int)index;

@end

@implementation MLPadMenuNavigationController

@synthesize visibleFrame = _visibleFrame;

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

    self.view.backgroundColor = [UIColor blueColor];
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
    _currentIndex = 0;
    _viewControllers = [[NSMutableArray arrayWithCapacity:0] retain];
}

#pragma mark - Pushing and Popping

- (void)pushViewController:(UIViewController <MenuViewController> *)viewController animated:(BOOL)animated
{
    [self.view addSubview:viewController.view];
    [_viewControllers addObject:viewController];
    viewController.menuNavigationController = self;
}

- (void)popViewControllerAnimated:(BOOL)animated
{
    NSLog(@"pop");
}

- (void)popToRootViewControllerAnimated:(BOOL)animated
{
    NSLog(@"pop to root");
}

- (void)addController:(UIViewController <MenuViewController> *)controller
{
    [self.view addSubview:controller.view];
    [_viewControllers addObject:controller];
    controller.menuNavigationController = self;
}

#pragma mark - Navigation

- (void)slideForwards
{
    NSLog(@"slide forwards");
}

- (void)slideBackwards
{
    NSLog(@"slide backwards");
}

#pragma mark - Getters

- (UIViewController *)topViewController {
    return [_viewControllers objectAtIndex:[_viewControllers count]-1];
}

- (UIViewController *)visibleViewController {
    return [_viewControllers objectAtIndex:_currentIndex]; //IMPLEMENT THIS
}

- (NSMutableArray *)viewControllers {
    return _viewControllers;
}

#pragma mark - Setters

- (void)setVisibleFrame:(CGRect)visibleFrame
{
    _visibleFrame = visibleFrame;
    
    self.view.frame = CGRectMake((-_currentIndex) * visibleFrame.size.width,
                                 visibleFrame.origin.y,
                                 visibleFrame.size.width,
                                 visibleFrame.size.height);
}

#pragma mark - Utility

- (CGRect)frameForIndex:(int)index {
    return CGRectMake(self.visibleFrame.size.width * index,
                      0,
                      self.visibleFrame.size.width,
                      self.visibleFrame.size.height);
}

@end
