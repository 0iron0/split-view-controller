//
//  MLPadSplitViewController.h
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/2/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLCourseMapItem, MLPadSplitViewController, MLPadRightViewController, MLPadMenuNavigationController;

@interface MLPadSplitViewController : UIViewController

@property (nonatomic, strong) MLPadMenuNavigationController *leftViewController;
@property (nonatomic, strong) MLPadRightViewController *rightViewController;

- (void)presentContentControllerForItem:(MLCourseMapItem *)item animated:(BOOL)animated;
- (void)presentPopupViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)presentPinViewController:(UIViewController *)pinController animated:(BOOL)animated;

- (void)slideContentControllerToBase;
- (void)slideContentControllerRight;
- (void)slideContentControllerToMax;
- (void)slideContentControllerToClosestSide;

- (BOOL)rightControllerIsPastLastLeftController;
- (BOOL)rightControllerIsBeforeBase;

- (void)updatedRightController;

@end
