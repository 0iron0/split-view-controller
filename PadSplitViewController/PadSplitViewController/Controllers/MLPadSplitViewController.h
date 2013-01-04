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

@property (nonatomic, assign) CGRect visibleFrame;

@end

@protocol RightViewControllerProtocol <NSObject>

@required
- (void)presentContentControllerForItem:(NSObject *)courseMapItem;
- (void)presentWebControllerForURL:(NSURL *)url;

@end

@interface MLPadSplitViewController : UIViewController

@property (nonatomic, retain) UIViewController <LeftViewControllerProtocol> *leftViewController;
@property (nonatomic, retain) UIViewController <RightViewControllerProtocol> *rightViewController;

- (void)presentPopupViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)presentPinViewController:(UIViewController *)pinController animated:(BOOL)animated;

@end
