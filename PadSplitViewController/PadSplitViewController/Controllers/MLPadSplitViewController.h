//
//  MLPadSplitViewController.h
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/2/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLCourseMapItem, MLPadSplitViewController, MLPadRightViewController;

@protocol LeftViewControllerProtocol <NSObject>

@required
@property (nonatomic, readonly) int visibleControllers;
@property (nonatomic, assign) int maxVisibleControllers;
@property (nonatomic, assign) CGRect minVisibleFrame;
@property (nonatomic, readonly) CGRect totalFrame;
@property (nonatomic, readonly) CGRect currentlyVisibleFrame;
@property (nonatomic, assign) MLPadSplitViewController *parent;

@end

@interface MLPadSplitViewController : UIViewController

@property (nonatomic, retain) UIViewController <LeftViewControllerProtocol> *leftViewController;
@property (nonatomic, retain) MLPadRightViewController *rightViewController;

- (void)presentContentControllerForItem:(MLCourseMapItem *)item animated:(BOOL)animated;
- (void)presentPopupViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)presentPinViewController:(UIViewController *)pinController animated:(BOOL)animated;

- (void)slideContentControllerRight;

@end
