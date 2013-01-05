//
//  MLPadMenuNavigationBar.m
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/4/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import "MLPadMenuNavigationBar.h"

#define MENU_NAV_BAR_TITLE_FONT [UIFont boldSystemFontOfSize:18]
#define MENU_NAV_BAR_TITLE_COLOR [UIColor colorWithRed:138.0/255 green:138.0/255 blue:138.0/255 alpha:1.0]

#define MENU_NAV_BAR_TITLE_BUTTON_BUFFER 5

@interface MLPadMenuNavigationBar () {
    UILabel *_titleLabel;
    UIButton *_leftBarButton;
    UIButton *_rightBarButton;
}

- (void)configureSelf;
- (void)configureTitleLabel;
- (void)configureLeftBarButton;
- (void)configureRightBarButton;

- (CGRect)leftBarButtonFrame;
- (CGRect)rightBarButtonFrame;
- (CGRect)titleLabelFrame;

@end

@implementation MLPadMenuNavigationBar

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
    }
    return self;
}

- (void)dealloc
{
    [_title release];
    [_leftBarButton release];
    [_rightBarButton release];
    [_titleLabel release];
    
    [super dealloc];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _leftBarButton.frame = [self leftBarButtonFrame];
    _rightBarButton.frame = [self rightBarButtonFrame];
    _titleLabel.frame = [self titleLabelFrame];
}

#pragma mark - Configuration

- (void)configureSelf
{
    self.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1.0];
}

- (void)configureTitleLabel
{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font                = MENU_NAV_BAR_TITLE_FONT;
    _titleLabel.textAlignment       = NSTextAlignmentCenter;
    _titleLabel.textColor           = MENU_NAV_BAR_TITLE_COLOR;
    _titleLabel.minimumScaleFactor  = 2.0;
    _titleLabel.backgroundColor     = [UIColor clearColor];
    [self addSubview:_titleLabel];
    self.title = @"";
}

- (void)configureLeftBarButton
{
    _leftBarButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    _leftBarButton.frame = CGRectZero;
    [self addSubview:_leftBarButton];
}

- (void)configureRightBarButton
{
    _rightBarButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    _rightBarButton.frame = CGRectZero;
    [self addSubview:_rightBarButton];
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
    return CGRectMake(0,
                      0,
                      0,
                      0);
}

- (CGRect)rightBarButtonFrame {
    return CGRectMake(0,
                      0,
                      0,
                      0);
}

- (CGRect)titleLabelFrame {
    return CGRectMake(CGRectGetMaxX(_leftBarButton.frame) + MENU_NAV_BAR_TITLE_BUTTON_BUFFER,
                      0,
                      self.bounds.size.width - _leftBarButton.bounds.size.width - _rightBarButton.bounds.size.width - MENU_NAV_BAR_TITLE_BUTTON_BUFFER,
                      self.bounds.size.height);
}

@end
