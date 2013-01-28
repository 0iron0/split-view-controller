//
//  MLPadMenuNavigationBar.h
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/4/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuNavigationBarParent <NSObject>

@optional
- (void)backButtonPressed;
- (void)menuButtonPressed;

@end

@interface MLPadMenuNavigationBar : UIView

@property (nonatomic, weak) NSObject <MenuNavigationBarParent> *parent;
@property (nonatomic, strong) NSString *title;

- (void)setBackButtonEnabled:(BOOL)enabled animated:(BOOL)animated;
- (void)setMenuButtonEnabled:(BOOL)enabled animated:(BOOL)animated;

@end
