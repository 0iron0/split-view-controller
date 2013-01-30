//
//  MLPadMenuNavigationBar.m
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/4/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import "MLPadMenuNavigationBar.h"

#define MENU_NAV_BAR_BACKGROUND_COLOR [UIColor colorWithRed:242.0/255 green:242.0/255 blue:242.0/255 alpha:1.0]

#define MENU_NAV_BAR_TITLE_FONT [UIFont fontWithName:@"Lato-Bold" size:17.0]
#define MENU_NAV_BAR_TITLE_COLOR [UIColor colorWithRed:138.0/255 green:138.0/255 blue:138.0/255 alpha:1.0]

#define MENU_NAV_BAR_TITLE_BUTTON_BUFFER 6

#define MENU_DIVIDER_COLOR [UIColor colorWithRed:189.0/255 green:189.0/255 blue:189.0/255 alpha:1.0]

@interface MLPadMenuNavigationBar () {
    UILabel *_titleLabel;
    UIButton *_backButton;
    UIButton *_menuButton;
    UIView *_bottomDivider;
}

- (void)configureSelf;
- (void)configureTitleLabel;
- (void)configureBackButton;
- (void)configureMenuButton;
- (void)configureBottomDivider;

- (CGRect)backButtonFrame;
- (CGRect)menuButtonFrame;
- (CGRect)titleLabelFrame;
- (CGRect)bottomDividerFrame;

@end

@implementation MLPadMenuNavigationBar

@synthesize parent;
@synthesize title = _title;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self configureSelf];
        [self configureTitleLabel];
        [self configureBackButton];
        [self configureMenuButton];
        [self configureBottomDivider];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _backButton.frame = [self backButtonFrame];
    _menuButton.frame = [self menuButtonFrame];
    _titleLabel.frame = [self titleLabelFrame];
    _bottomDivider.frame = [self bottomDividerFrame];
}

#pragma mark - Configuration

- (void)configureSelf
{
    self.backgroundColor = MENU_NAV_BAR_BACKGROUND_COLOR;
}

- (void)configureTitleLabel
{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font                        = MENU_NAV_BAR_TITLE_FONT;
    _titleLabel.textAlignment               = NSTextAlignmentCenter;
    _titleLabel.textColor                   = MENU_NAV_BAR_TITLE_COLOR;
    _titleLabel.minimumScaleFactor          = 0.6;
    _titleLabel.adjustsFontSizeToFitWidth   = YES;
    _titleLabel.backgroundColor             = [UIColor clearColor];
    [self addSubview:_titleLabel];
    self.title = @"";
}

- (void)configureBackButton
{
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectZero;
    [_backButton setImage:[UIImage imageNamed:@"MLBackArrow.png"] forState:UIControlStateNormal];
    _backButton.alpha = 0;
    [_backButton addTarget:self.parent action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
}

- (void)configureMenuButton
{
    _menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _menuButton.frame = CGRectZero;
    [_menuButton setImage:[UIImage imageNamed:@"MLMenuIcon.png"] forState:UIControlStateNormal];
    _menuButton.alpha = 0;
    [_menuButton addTarget:self.parent action:@selector(menuButtonPressed) forControlEvents:UIControlEventTouchUpInside];
}

- (void)configureBottomDivider
{
    _bottomDivider = [[UIView alloc] init];
    _bottomDivider.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _bottomDivider.backgroundColor = MENU_DIVIDER_COLOR;
    [self addSubview:_bottomDivider];
}

#pragma mark - Bar Button Items

- (void)setBackButtonEnabled:(BOOL)enabled animated:(BOOL)animated
{
    if (enabled)
        [self addSubview:_backButton];

    [UIView animateWithDuration:(animated ? 0.3 : 0)
                          delay:0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^(void) {
                         if (enabled) 
                             _backButton.alpha = 1;
                         else 
                             _backButton.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         if (!enabled)
                             [_backButton removeFromSuperview];
                         
                     }];
}

- (void)setMenuButtonEnabled:(BOOL)enabled animated:(BOOL)animated
{
    if (enabled)
        [self addSubview:_menuButton];
    
    [UIView animateWithDuration:(animated ? 0.3 : 0)
                          delay:0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^(void) {
                         if (enabled)
                             _menuButton.alpha = 1;
                         else
                             _menuButton.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         if (!enabled)
                             [_menuButton removeFromSuperview];
                         
                     }];
}

#pragma mark - Setters

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _titleLabel.text = _title;
}

#pragma mark - Frames

- (CGRect)backButtonFrame {
    return CGRectMake(MENU_NAV_BAR_TITLE_BUTTON_BUFFER,
                      CGRectGetMidY(self.bounds) - _backButton.imageView.image.size.height/2,
                      _backButton.imageView.image.size.width,
                      _backButton.imageView.image.size.height);
}

- (CGRect)menuButtonFrame {
    return CGRectMake(MENU_NAV_BAR_TITLE_BUTTON_BUFFER*2,
                      CGRectGetMidY(self.bounds) - _backButton.imageView.image.size.height/2,
                      _backButton.imageView.image.size.width,
                      _backButton.imageView.image.size.height);
}

- (CGRect)titleLabelFrame {
    return CGRectMake(_backButton.bounds.size.width + MENU_NAV_BAR_TITLE_BUTTON_BUFFER*2,
                      0,
                      self.bounds.size.width - _backButton.bounds.size.width*2 - MENU_NAV_BAR_TITLE_BUTTON_BUFFER*4,
                      self.bounds.size.height);
}

- (CGRect)bottomDividerFrame {
    return CGRectMake(0,
                      self.bounds.size.height - 1,
                      self.bounds.size.width,
                      1);
}

@end
