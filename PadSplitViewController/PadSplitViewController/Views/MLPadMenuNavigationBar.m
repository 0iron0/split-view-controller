//
//  MLPadMenuNavigationBar.m
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/4/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import "MLPadMenuNavigationBar.h"

#define MENU_NAV_BAR_BACKGROUND_COLOR [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1.0]

#define MENU_NAV_BAR_TITLE_FONT [UIFont fontWithName:@"Lato-Bold" size:17.0]
#define MENU_NAV_BAR_TITLE_COLOR [UIColor colorWithRed:138.0/255 green:138.0/255 blue:138.0/255 alpha:1.0]

#define MENU_NAV_BAR_TITLE_BUTTON_BUFFER 6

#define MENU_DIVIDER_COLOR [UIColor colorWithRed:189.0/255 green:189.0/255 blue:189.0/255 alpha:1.0]

@interface MLPadMenuNavigationBar () {
    UILabel *_titleLabel;
    UIButton *_leftBarButton;
    UIButton *_rightBarButton;
    UIView *_bottomDivider;
}

- (void)configureSelf;
- (void)configureTitleLabel;
- (void)configureLeftBarButton;
- (void)configureRightBarButton;
- (void)configureBottomDivider;

- (CGRect)leftBarButtonFrame;
- (CGRect)rightBarButtonFrame;
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
        [self configureLeftBarButton];
        [self configureRightBarButton];
        [self configureBottomDivider];
    }
    return self;
}

- (void)dealloc
{
    [_title release];
    [_leftBarButton release];
    [_rightBarButton release];
    [_titleLabel release];
    [_bottomDivider release];
    
    [super dealloc];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _leftBarButton.frame = [self leftBarButtonFrame];
    _rightBarButton.frame = [self rightBarButtonFrame];
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
    NSLog(@"FONTS: %@", [UIFont fontNamesForFamilyName:@"Lato"]);
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

- (void)configureLeftBarButton
{
    _leftBarButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    _leftBarButton.frame = CGRectZero;
    [_leftBarButton setImage:[UIImage imageNamed:@"MLBackArrow.png"] forState:UIControlStateNormal];
    _leftBarButton.alpha = 0;
    [_leftBarButton addTarget:self.parent action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
}

- (void)configureRightBarButton
{
    _rightBarButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    _rightBarButton.frame = CGRectZero;
    [self addSubview:_rightBarButton];
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
        [self addSubview:_leftBarButton];

    [UIView animateWithDuration:(animated ? 0.3 : 0)
                          delay:0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^(void) {
                         if (enabled) 
                             _leftBarButton.alpha = 1;
                         else 
                             _leftBarButton.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         if (!enabled)
                             [_leftBarButton removeFromSuperview];
                         
                     }];
}

#pragma mark - Setters

- (void)setTitle:(NSString *)title
{
    [_title release];
    _title = title;
    
    _titleLabel.text = _title;
}

#pragma mark - Frames

- (CGRect)leftBarButtonFrame {
    return CGRectMake(MENU_NAV_BAR_TITLE_BUTTON_BUFFER,
                      CGRectGetMidY(self.bounds) - _leftBarButton.imageView.image.size.height/2,
                      _leftBarButton.imageView.image.size.width,
                      _leftBarButton.imageView.image.size.height);
}

- (CGRect)rightBarButtonFrame {
    return CGRectMake(0,
                      0,
                      0,
                      0);
}

- (CGRect)titleLabelFrame {
    return CGRectMake(_leftBarButton.bounds.size.width + MENU_NAV_BAR_TITLE_BUTTON_BUFFER*2,
                      0,
                      self.bounds.size.width - _leftBarButton.bounds.size.width*2 - MENU_NAV_BAR_TITLE_BUTTON_BUFFER*4,
                      self.bounds.size.height);
}

- (CGRect)bottomDividerFrame {
    return CGRectMake(0,
                      self.bounds.size.height - 1,
                      self.bounds.size.width,
                      1);
}

@end
