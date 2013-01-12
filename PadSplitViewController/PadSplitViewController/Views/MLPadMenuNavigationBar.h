//
//  MLPadMenuNavigationBar.h
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/4/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuNavigationBarParent <NSObject>

@required
- (void)backButtonPressed;

@end

@interface MLPadMenuNavigationBar : UIView

@property (nonatomic, assign) NSObject <MenuNavigationBarParent> *parent;
@property (nonatomic, retain) NSString *title;

- (void)setBackButtonEnabled:(BOOL)enabled animated:(BOOL)animated;

@end
