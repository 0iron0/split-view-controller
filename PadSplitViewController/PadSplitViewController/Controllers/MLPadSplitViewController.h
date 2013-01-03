//
//  MLPadSplitViewController.h
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/2/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLPadSplitViewController : UIViewController

@property (nonatomic, retain) UIViewController *leftViewController;
@property (nonatomic, retain) UIViewController *rightViewController;

- (void)presentPopupViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)presentPinViewController:(UIViewController *)pinController animated:(BOOL)animated;

@end
