//
//  MLPadSplitViewController.h
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/2/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftViewControllerProtocol <NSObject>

@required


@property (nonatomic, readonly) int visibleControllers;
@property (nonatomic, assign) int maxVisibleControllers;
@property (nonatomic, assign) CGRect minVisibleFrame;
@property (nonatomic, readonly) CGRect totalFrame;
@property (nonatomic, readonly) CGRect currentlyVisibleFrame;

@end

@protocol RightViewControllerProtocol <NSObject>

@required
- (void)presentContentControllerForItem:(NSObject *)courseMapItem;
- (void)presentWebControllerForURL:(NSURL *)url;

@end

@interface MLPadSplitViewController : UIViewController

@property (nonatomic, retain) UIViewController <LeftViewControllerProtocol> *leftViewController;
@property (nonatomic, retain) UIViewController <RightViewControllerProtocol> *rightViewController;

- (void)presentContentViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)presentPopupViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)presentPinViewController:(UIViewController *)pinController animated:(BOOL)animated;

@end
