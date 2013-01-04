//
//  MLPadMenuViewController.h
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/2/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLPadMenuNavigationController.h"
#import "MLPadMenuNavigationBar.h"

@interface MLPadMenuViewController : UIViewController <MenuViewController>

@property (nonatomic, assign) UIViewController *menuNavigationController;
@property (nonatomic, retain) MLPadMenuNavigationBar *navigationBar;

@end
