//
//  MLPadRightViewController.h
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/14/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLPadSplitViewController.h"

@class MLCourseMapItem;

@interface MLPadRightViewController : UIViewController <RightViewControllerProtocol>

- (void)presentContentControllerForItem:(MLCourseMapItem *)item animated:(BOOL)animated;
- (void)presentWebControllerForURL:(NSURL *)url;

- (void)slideRight;

- (BOOL)isDisplayingController;

@end
