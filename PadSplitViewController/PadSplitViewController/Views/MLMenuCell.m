//
//  MLMenuCell.m
//  PadSplitViewController
//
//  Created by Justin Brunet on 1/7/13.
//  Copyright (c) 2013 Justin Brunet. All rights reserved.
//

#import "MLMenuCell.h"

#define MENU_CELL_FONT [UIFont fontWithName:@"Lato-Bold" size:17.0]
#define MENU_CELL_TEXT_LEFT_BUFFER 16
#define MENU_CELL_TEXT_RIGHT_BUFFER 4
#define MENU_CELL_DEFAULT_TEXT_COLOR [UIColor colorWithRed:45.0/255 green:45.0/255 blue:45.0/255 alpha:1.0]

#define MENU_CELL_COLOR_BAR_WIDTH 6
#define MENU_CELL_COLOR_BAR_BUFFER 12

#define MENU_CELL_UNREAD_ITEMS_VIEW_HEIGHT 20
#define MENU_CELL_UNREAD_ITEMS_FONT [UIFont fontWithName:@"Lato-Bold" size:12.0]

#define MENU_CELL_ARROW_BUFFER 10

#define MENU_CELL_SELECTED_GRAY_COLOR [UIColor colorWithRed:232.0/255 green:232.0/255 blue:232.0/255 alpha:1.0]

@interface MLMenuCell () {
    UIView *_colorBar;
    UIView *_unreadItemsView;
    UIImageView *_arrow;
    UILabel *_unreadItemsLabel;
    UIView *_selectionView;
}

- (void)configureSelf;
- (void)configureTextLabel;
- (void)configureColorBar;
- (void)configureUnreadItemsView;
- (void)configureUnreadItemsLabel;
- (void)configureArrow;
- (void)configureSelectionView;

- (void)hideView:(UIView *)view animated:(BOOL)animated;
- (void)showView:(UIView *)view animated:(BOOL)animated;

- (void)animateSelectionViewIn;

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
        [self configureSelectionView];
        self.color = [UIColor colorWithRed:75.0/255 green:75.0/255 blue:75.0/255 alpha:1.0];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.frame = [self textLabelFrame];
    self.textLabel.backgroundColor = [UIColor clearColor];
    _arrow.frame = [self arrowFrame];
    _unreadItemsView.frame = [self unreadItemsViewFrame];
}

#pragma mark - View Configuration

- (void)configureSelf
{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.clipsToBounds = YES;
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
    _unreadItemsLabel.font = MENU_CELL_UNREAD_ITEMS_FONT;
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

- (void)configureSelectionView
{
    _selectionView = [[UIView alloc] init];
    _selectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _selectionView.frame = self.bounds;
    _selectionView.alpha = 0;
    [self addSubview:_selectionView];
    [self sendSubviewToBack:_selectionView];
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

#pragma mark - Selection

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (selected)
    {
        _selectionView.alpha = 1;
        self.textLabel.textColor = MENU_CELL_SELECTED_GRAY_COLOR;
        [self animateSelectionViewIn];
    }
    else
    {
        _selectionView.alpha = 0;
        self.textLabel.textColor = [self textLabelColor];
        _unreadItemsView.backgroundColor = _color;
        _unreadItemsLabel.textColor = [UIColor whiteColor];
    }
}

- (void)animateSelectionViewIn
{
    CGRect previousFrame = _selectionView.frame;
    _selectionView.frame = CGRectMake(previousFrame.origin.x - previousFrame.size.width, previousFrame.origin.y, previousFrame.size.width, previousFrame.size.height);
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^(void) {
                         _selectionView.frame = previousFrame;
                         _unreadItemsView.backgroundColor = MENU_CELL_SELECTED_GRAY_COLOR;
                         _unreadItemsLabel.textColor = _color;
                     }
                     completion:^(BOOL finished) {
                     }];
}

#pragma mark - Setters and Getters

- (void)setTitle:(NSString *)title {
    self.textLabel.text = title;
}

- (NSString *)title {
    return self.textLabel.text;
}

- (void)setColor:(UIColor *)color {
    _color = color;
    
    _colorBar.backgroundColor = _color;
    _unreadItemsView.backgroundColor = _color;
    _selectionView.backgroundColor = _color;
    self.textLabel.textColor = [self textLabelColor];
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

- (UIColor *)textLabelColor {
    return MENU_CELL_DEFAULT_TEXT_COLOR;
}

@end
