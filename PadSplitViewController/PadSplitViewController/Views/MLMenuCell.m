//
//  MLMenuCell.m
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/7/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import "MLMenuCell.h"

#define MENU_CELL_FONT [UIFont systemFontOfSize:16]
#define MENU_CELL_TEXT_LEFT_BUFFER 16
#define MENU_CELL_TEXT_RIGHT_BUFFER 6

#define MENU_CELL_COLOR_BAR_WIDTH 6
#define MENU_CELL_COLOR_BAR_BUFFER 12

#define MENU_CELL_UNREAD_ITEMS_VIEW_HEIGHT 20
#define MENU_CELL_UNREAD_ITEMS_ARROW_BUFFER 5

@interface MLMenuCell () {
    UIView *_colorBar;
    UIView *_unreadItemsView;
}

- (void)configureSelf;
- (void)configureTextLabel;
- (void)configureColorBar;
- (void)configureUnreadItemsView;

- (void)hideColorBar;
- (void)showColorBar;
- (void)hideUnreadItemsView;
- (void)showUnreadItemsViews;

- (CGRect)colorBarFrame;
- (CGRect)unreadItemsViewFrame;
- (CGRect)textLabelFrame;

@end

@implementation MLMenuCell

@synthesize title = _title;
@synthesize color = _color;
@synthesize unreadItems = _unreadItems;

#pragma mark - Lifecycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self configureSelf];
        [self configureTextLabel];
        [self configureColorBar];
        [self configureUnreadItemsView];
    }
    return self;
}

- (void)dealloc
{
    [_color release];
    [_colorBar release];
    [_unreadItemsView release];
    
    [super dealloc];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.frame = [self textLabelFrame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#pragma mark - View Configuration

- (void)configureSelf
{
    self.backgroundColor = [UIColor clearColor];
}

- (void)configureTextLabel
{
    self.textLabel.font = MENU_CELL_FONT;
}

- (void)configureColorBar
{
    _colorBar = [[UIView alloc] init];
    _colorBar.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _colorBar.frame = [self colorBarFrame];
    _colorBar.alpha = 0;
    [self addSubview:_colorBar];
}

- (void)configureUnreadItemsView
{
    _unreadItemsView = [[UIView alloc] init];
    _unreadItemsView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    _unreadItemsView.frame = [self unreadItemsViewFrame];
    _unreadItemsView.alpha = 0;
    [self addSubview:_unreadItemsView];
}

#pragma mark - View Showing/Hiding

- (void)hideColorBar
{
    [UIView animateWithDuration:0.3
                     animations:^(void) {
                         _colorBar.alpha = 0;
                     }
     ];
}

- (void)showColorBar
{
    [UIView animateWithDuration:0.3
                     animations:^(void) {
                         _colorBar.alpha = 1;
                     }
     ];
}

- (void)hideUnreadItemsView
{
    [UIView animateWithDuration:0.3
                     animations:^(void) {
                         _unreadItemsView.alpha = 0;
                     }
     ];
}

- (void)showUnreadItemsViews
{
    [UIView animateWithDuration:0.3
                     animations:^(void) {
                         _unreadItemsView.alpha = 1;
                     }
     ];
}

#pragma mark - Setters and Getters

- (void)setTitle:(NSString *)title {
    self.textLabel.text = title;
}

- (NSString *)title {
    return self.textLabel.text;
}

- (void)setColor:(UIColor *)color {
    [_color release];
    _color = color;
    
    self.textLabel.textColor = _color;
    _colorBar.backgroundColor = _color;
    _unreadItemsView.backgroundColor = _color;
}

- (void)setUnreadItems:(int)unreadItems {
    _unreadItems = unreadItems;
    
    if (_unreadItems == 0) {
        [self hideUnreadItemsView];
        [self hideColorBar];
    }
    else {
        [self showUnreadItemsViews];
        [self showColorBar];
    }
}

#pragma mark - Frames

- (CGRect)colorBarFrame {
    return CGRectMake(0,
                      MENU_CELL_COLOR_BAR_BUFFER,
                      MENU_CELL_COLOR_BAR_WIDTH,
                      self.bounds.size.height - MENU_CELL_COLOR_BAR_BUFFER*2);
}

- (CGRect)unreadItemsViewFrame {
    return CGRectMake(CGRectGetMaxX(self.bounds) - MENU_CELL_UNREAD_ITEMS_VIEW_HEIGHT - MENU_CELL_UNREAD_ITEMS_ARROW_BUFFER,
                      CGRectGetMidY(self.bounds) - MENU_CELL_UNREAD_ITEMS_VIEW_HEIGHT/2,
                      MENU_CELL_UNREAD_ITEMS_VIEW_HEIGHT,
                      MENU_CELL_UNREAD_ITEMS_VIEW_HEIGHT);
}

- (CGRect)textLabelFrame {
    return CGRectMake(CGRectGetMaxX(_colorBar.frame) + MENU_CELL_TEXT_LEFT_BUFFER,
                      self.textLabel.frame.origin.y,
                      _unreadItemsView.frame.origin.x - MENU_CELL_TEXT_RIGHT_BUFFER - (CGRectGetMaxX(_colorBar.frame) + MENU_CELL_TEXT_LEFT_BUFFER),
                      self.textLabel.frame.size.height);
}

@end
