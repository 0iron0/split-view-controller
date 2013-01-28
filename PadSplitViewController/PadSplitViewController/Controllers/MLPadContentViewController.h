//
//  MLPadContentViewController.h
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/16/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLPadRightViewController, MLPadMenuNavigationBar;

@interface MLPadContentViewController : UIViewController

@property (nonatomic, weak) MLPadRightViewController *parent;
@property (nonatomic, strong) MLPadMenuNavigationBar *navigationBar;

- (BOOL)shouldShowNavigationBar;

@end
