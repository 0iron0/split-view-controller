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

@property (nonatomic, retain) MLPadMenuNavigationController *leftViewController;
@property (nonatomic, retain) MLPadRightViewController *rightViewController;

- (void)presentContentControllerForItem:(MLCourseMapItem *)item animated:(BOOL)animated;
- (void)presentPopupViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)presentPinViewController:(UIViewController *)pinController animated:(BOOL)animated;

- (void)slideContentControllerRight;
- (void)slideContentControllerLeft;

@end
