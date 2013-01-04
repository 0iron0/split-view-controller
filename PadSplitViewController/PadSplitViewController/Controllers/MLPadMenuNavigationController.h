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

@interface MLPadMenuNavigationController : UIViewController <LeftViewControllerProtocol>

@property (nonatomic, readonly) UIViewController <MenuViewController> *topViewController;
@property (nonatomic, readonly) UIViewController <MenuViewController> *visibleViewController;
@property (nonatomic, readonly) NSMutableArray *viewControllers;
@property (nonatomic, assign) CGRect visibleFrame;

- (id)initWithRootViewController:(UIViewController <MenuViewController> *)rootController;

- (void)pushViewController:(UIViewController <MenuViewController> *)viewController animated:(BOOL)animated;
- (void)popViewControllerAnimated:(BOOL)animated;
- (void)popToRootViewControllerAnimated:(BOOL)animated;

- (void)slideForwards;
- (void)slideBackwards;

@end
