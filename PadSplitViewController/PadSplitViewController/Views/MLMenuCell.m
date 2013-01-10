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
#define MENU_CELL_TEXT_RIGHT_BUFFER 4
#define MENU_CELL_DEFAUL_TEXT_COLOR [UIColor colorWithRed:45.0/255 green:45.0/255 blue:45.0/255 alpha:1.0]

#define MENU_CELL_COLOR_BAR_WIDTH 6
#define MENU_CELL_COLOR_BAR_BUFFER 12

#define MENU_CELL_UNREAD_ITEMS_VIEW_HEIGHT 20

#define MENU_CELL_ARROW_BUFFER 10

@interface MLMenuCell () {
    UIView *_colorBar;
    UIView *_unreadItemsView;
    UIImageView *_arrow;
    UILabel *_unreadItemsLabel;
}

- (void)configureSelf;
- (void)configureTextLabel;
- (void)configureColorBar;
- (void)configureUnreadItemsView;
- (void)configureUnreadItemsLabel;
- (void)configureArrow;

- (void)hideView:(UIView *)view animated:(BOOL)animated;
- (void)showView:(UIView *)view animated:(BOOL)animated;

- (CGRect)colorBarFrame;
- (CGRect)unreadItemsViewFrame;
- (CGRect)unreadItemsLabelFrame;
- (CGRect)arrowFrame;

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
        [self configureUnreadItemsLabel];
        [self configureArrow];
    }
    return self;
}

- (void)dealloc
{
    [_color release];
    [_colorBar release];
    [_unreadItemsView release];
    [_unreadItemsLabel release];
    [_arrow release];
    
    [super dealloc];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.frame = [self textLabelFrame];
    _arrow.frame = [self arrowFrame];
    _unreadItemsView.frame = [self unreadItemsViewFrame];
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
    _unreadItemsView.layer.cornerRadius = _unreadItemsView.bounds.size.height/2;
    [self addSubview:_unreadItemsView];
}

- (void)configureUnreadItemsLabel
{
    _unreadItemsLabel = [[UILabel alloc] init];
    _unreadItemsLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _unreadItemsLabel.frame = [self unreadItemsLabelFrame];
    _unreadItemsLabel.font = [UIFont boldSystemFontOfSize:12];
    _unreadItemsLabel.textColor = [UIColor whiteColor];
    _unreadItemsLabel.textAlignment = NSTextAlignmentCenter;
    _unreadItemsLabel.backgroundColor = [UIColor clearColor];
    [_unreadItemsView addSubview:_unreadItemsLabel];
}

- (void)configureArrow
{
    _arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
    [self addSubview:_arrow];
}

#pragma mark - View Showing/Hiding

- (void)hideView:(UIView *)view animated:(BOOL)animated
{
    [UIView animateWithDuration:(animated ? 0.3 : 0)
                     animations:^(void) {
                         view.alpha = 0;
                     }
     ];
}

- (void)showView:(UIView *)view animated:(BOOL)animated
{
    [UIView animateWithDuration:(animated ? 0.3 : 0)
                     animations:^(void) {
                         view.alpha = 1;
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
    _color = [color retain];
    
    _colorBar.backgroundColor = _color;
    _unreadItemsView.backgroundColor = _color;
}

- (void)setUnreadItems:(int)unreadItems {
    _unreadItems = unreadItems;
    
    if (_unreadItems == 0) {
        [self hideView:_unreadItemsView animated:YES];
        [self hideView:_colorBar animated:YES];
    }
    else {
        [self showView:_unreadItemsView animated:YES];
        [self showView:_colorBar animated:YES];
        _unreadItemsLabel.text = [NSString stringWithFormat:@"%i", _unreadItems];
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
    return CGRectMake(_arrow.frame.origin.x - MENU_CELL_UNREAD_ITEMS_VIEW_HEIGHT - MENU_CELL_ARROW_BUFFER,
                      CGRectGetMidY(self.bounds) - MENU_CELL_UNREAD_ITEMS_VIEW_HEIGHT/2,
                      MENU_CELL_UNREAD_ITEMS_VIEW_HEIGHT,
                      MENU_CELL_UNREAD_ITEMS_VIEW_HEIGHT);
}

- (CGRect)unreadItemsLabelFrame {
    return CGRectMake(0,
                      0,
                      _unreadItemsView.bounds.size.width,
                      _unreadItemsView.bounds.size.height-1);
}
- (CGRect)textLabelFrame {
    return CGRectMake(CGRectGetMaxX(_colorBar.frame) + [self textLeftBuffer],
                      self.textLabel.frame.origin.y,
                      _unreadItemsView.frame.origin.x - MENU_CELL_TEXT_RIGHT_BUFFER - (CGRectGetMaxX(_colorBar.frame) + [self textLeftBuffer]),
                      self.textLabel.frame.size.height);
}

- (CGRect)arrowFrame {
    CGSize arrowSize = [UIImage imageNamed:@"arrow.png"].size;
    return CGRectMake(self.bounds.size.width - MENU_CELL_ARROW_BUFFER - arrowSize.width,
                      CGRectGetMidY(self.bounds) - arrowSize.height/2,
                      arrowSize.width,
                      arrowSize.height);
}

#pragma mark - View Defines

- (float)textLeftBuffer {
    return MENU_CELL_TEXT_LEFT_BUFFER;
}

@end
