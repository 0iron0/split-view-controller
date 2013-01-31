//
//  MLPadMenuNavigationController.h
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/2/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLPadSplitViewController.h"

@protocol MenuViewController <NSObject>

@required
@property (nonatomic, assign) UIViewController *menuNavigationController;

@end

@interface MLPadMenuNavigationController : UIViewController

@property (weak, nonatomic, readonly) UIViewController <MenuViewController> *topViewController;
@property (weak, nonatomic, readonly) UIViewController <MenuViewController> *visibleViewController;
@property (weak, nonatomic, readonly) NSMutableArray *viewControllers;
@property (nonatomic, assign) CGRect minVisibleFrame;
@property (nonatomic, assign) int maxVisibleControllers;
@property (nonatomic, readonly) int visibleControllers;
@property (nonatomic, readonly) int firstVisibleIndex;
@property (nonatomic, weak) MLPadSplitViewController *parent;

- (id)initWithRootViewController:(UIViewController <MenuViewController> *)rootController;

- (void)pushViewController:(UIViewController <MenuViewController> *)viewController animated:(BOOL)animated;
- (void)popViewControllerAnimated:(BOOL)animated;
- (void)popToRootViewControllerAnimated:(BOOL)animated;
- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)presentContentControllerForItem:(MLCourseMapItem *)item animated:(BOOL)animated;

- (void)slideForwards;
- (void)slideBackwards;

- (void)animateControllersGivenFirstVisibleIndex:(int)index;

- (CGRect)totalFrame;
- (CGRect)currentlyVisibleFrame;

- (BOOL)hasHiddenController;

@end
